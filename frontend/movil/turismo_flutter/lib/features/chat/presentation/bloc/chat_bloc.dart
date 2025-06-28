import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/chat/data/models/mensaje_dto.dart';
import 'package:turismo_flutter/features/chat/domain/entities/mensaje.dart';
import '../../domain/usecases/conectar_chat.dart';
import '../../domain/usecases/desconectar_chat.dart';
import '../../domain/usecases/enviar_mensaje.dart';
import '../../domain/usecases/editar_mensaje.dart';
import '../../domain/usecases/marcar_como_entregado.dart';
import '../../domain/usecases/marcar_como_leido.dart';
import '../../data/datasources/remote/chat_websocket_datasource.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import 'package:turismo_flutter/features/chat/data/mappers/mensaje_mapper.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ConectarChat conectarChat;
  final DesconectarChat desconectarChat;
  final EnviarMensaje enviarMensaje;
  final EditarMensaje editarMensaje;
  final MarcarComoEntregado marcarComoEntregado;
  final MarcarComoLeido marcarComoLeido;

  final ChatWebSocketDatasource _datasource;

  final List<Mensaje> _mensajes = [];

  final String usuarioActual;

  ChatBloc({
    required this.conectarChat,
    required this.desconectarChat,
    required this.enviarMensaje,
    required this.editarMensaje,
    required this.marcarComoEntregado,
    required this.marcarComoLeido,
    required this.usuarioActual,
    required ChatWebSocketDatasource datasource, // <-- NUEVO
  })  : _datasource = datasource,
        super(ChatInitial()) {
    // Listeners desde el datasource
    _datasource.onMensajeRecibido = (dto) {
      final entity = dto.toEntity();
      if (entity == null) {
        print('⚠️ Ignorando mensaje recibido inválido');
        return;
      }
      add(MensajeRecibidoEvent(entity));
    };

    _datasource.onEstadoMensaje = (dto) {
      final entity = dto.toEntity();
      if (entity == null || (entity.id == null && entity.idTemporal == null)) {
        print('⚠️ Ignorando estado sin id/idTemporal o entidad nula: $entity');
        return;
      }
      add(EstadoMensajeActualizadoEvent(entity));
    };

    _datasource.onMensajeEditado = (dto) {
      final entity = dto.toEntity();
      if (entity == null) {
        print('⚠️ Ignorando mensaje editado inválido');
        return;
      }
      add(MensajeEditadoRecibidoEvent(entity));
    };
    // Eventos
    on<ConectarChatEvent>((event, emit) {
      conectarChat();
      emit(ChatConnected());
    });

    on<DesconectarChatEvent>((event, emit) {
      desconectarChat();
      emit(ChatDisconnected());
    });

    on<EnviarMensajeEvent>((event, emit) {
      enviarMensaje(event.mensaje);
      _mensajes.add(event.mensaje); // localmente
      emit(ChatMensajesEstado(List.from(_mensajes)));
    });

    on<MarcarComoEntregadoEvent>((event, emit) {
      marcarComoEntregado(emisor: event.emisor, receptor: event.receptor);
    });

    on<MarcarComoLeidoEvent>((event, emit) {
      marcarComoLeido(emisor: event.emisor, receptor: event.receptor);
    });

    on<MensajeEditadoRecibidoEvent>((event, emit) {
      print('✏️ MensajeEditadoRecibidoEvent: id=${event.mensaje.id}, idTemporal=${event.mensaje.idTemporal}');

      _actualizarMensaje(event.mensaje);
      emit(ChatMensajesEstado(List.from(_mensajes)));
    });

    on<MensajeRecibidoEvent>((event, emit) {
      print('📩 MensajeRecibidoEvent recibido: ${event.mensaje}');
      _mensajes.add(event.mensaje);
      emit(ChatMensajesEstado(List.from(_mensajes)));
    });

    on<EstadoMensajeActualizadoEvent>((event, emit) {
      print('🟢 EstadoMensajeActualizadoEvent: id=${event.mensaje.id}, idTemporal=${event.mensaje.idTemporal}, estado=${event.mensaje.estado}');

      _actualizarMensaje(event.mensaje);
      emit(ChatMensajesEstado(List.from(_mensajes)));
    });
  }

  int _estadoValor(String? estado) {
    switch (estado) {
      case 'LEIDO':
        return 4;
      case 'ENTREGADO':
        return 3;
      case 'ENVIADO':
        return 2;
      case 'PENDIENTE':
        return 1;
      default:
        return 0;
    }
  }

  void _actualizarMensaje(Mensaje nuevo) {
    print('🔍 Actualizando mensaje: id=${nuevo.id}, idTemporal=${nuevo.idTemporal}, texto=${nuevo.texto}, estado=${nuevo.estado}');

    if (nuevo.id == null && nuevo.idTemporal == null) {
      print('⚠️ _actualizarMensaje ignorando mensaje sin id ni idTemporal: $nuevo');
      return;
    }

    // Buscar por ID directo
    int index = _mensajes.indexWhere((m) =>
    (nuevo.id != null && m.id == nuevo.id) ||
        (nuevo.idTemporal != null && m.idTemporal == nuevo.idTemporal));

    if (index != -1) {
      // Si encontramos coincidencia directa, actualizamos
      final actual = _mensajes[index];

      final actualizado = actual.copyWith(
        id: nuevo.id ?? actual.id,
        idTemporal: actual.idTemporal, // conserva el idTemporal original
        estado: nuevo.estado ?? actual.estado,
        texto: nuevo.texto ?? actual.texto,
        archivo: nuevo.archivo ?? actual.archivo,
        fecha: nuevo.fecha ?? actual.fecha,
      );

      _mensajes[index] = actualizado;
    } else {
      // Intentar reconciliar por heurística (emisor+texto+fecha cercana)
      final idxHeuristico = _mensajes.indexWhere((m) =>
      m.idTemporal != null &&
          nuevo.id != null &&
          m.emisor == nuevo.emisor &&
          m.texto == nuevo.texto &&
          m.tipo == nuevo.tipo &&
          (m.fecha != null &&
              nuevo.fecha != null &&
              (m.fecha!.difference(nuevo.fecha!).inSeconds).abs() < 60));

      if (idxHeuristico != -1) {
        final actual = _mensajes[idxHeuristico];
        final actualizado = actual.copyWith(
          id: nuevo.id, // asigna el id definitivo
          estado: nuevo.estado ?? actual.estado,
          texto: nuevo.texto ?? actual.texto,
          archivo: nuevo.archivo ?? actual.archivo,
          fecha: nuevo.fecha ?? actual.fecha,
        );
        _mensajes[idxHeuristico] = actualizado;
      } else {
        // No se encontró nada similar, agregar
        _mensajes.add(nuevo);
      }
    }

    // Asegurar que no haya duplicados por id/idTemporal
    final seen = <String, Mensaje>{};

    for (var m in _mensajes) {
      final key = m.id?.toString() ?? m.idTemporal ?? UniqueKey().toString();

      if (!seen.containsKey(key)) {
        seen[key] = m;
      } else {
        final existing = seen[key]!;
        if (_estadoValor(m.estado) > _estadoValor(existing.estado)) {
          seen[key] = m;
        }
      }
    }

    _mensajes
      ..clear()
      ..addAll(seen.values);
  }

}