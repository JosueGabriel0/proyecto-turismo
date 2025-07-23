import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:turismo_flutter/config/constants/constants.dart';
import 'package:turismo_flutter/config/theme/local_theme_provider.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/admin/data/models/chat_resumen_dto.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/mensaje/mensaje_admin_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/mensaje/mensaje_admin_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/mensaje/mensaje_admin_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/file/file_admin_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/file/file_admin_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/file/file_admin_state.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/chat/imagen_mensaje_widget.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/chat/video_mensaje_widget.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/chat/domain/entities/mensaje.dart';
import 'package:turismo_flutter/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:turismo_flutter/features/chat/presentation/bloc/chat_event.dart';
import 'package:turismo_flutter/features/chat/presentation/bloc/chat_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:turismo_flutter/features/chat/data/mappers/mensaje_mapper.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChatAdminPersonalScreen extends StatefulWidget {
  final String? idUsuario;
  final String? username;
  final ChatResumenDto chat;

  const ChatAdminPersonalScreen({
    super.key,
    required this.idUsuario,
    required this.username,
    required this.chat,
  });

  @override
  State<ChatAdminPersonalScreen> createState() => _ChatAdminPersonalScreenState();
}

class _ChatAdminPersonalScreenState extends State<ChatAdminPersonalScreen> {
  final TextEditingController _controller = TextEditingController();
  String? emisor;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final tokenService = TokenStorageService();
      final token = await tokenService.getToken();
      emisor = getUsernameFromToken(token);

      if (token != null && widget.username != null && widget.idUsuario != null) {
        context.read<MensajeAdminBloc>().add(ObtenerHistorialEvent(int.parse(widget.idUsuario!)));
        context.read<ChatBloc>().add(ConectarChatEvent());
      } else {
        debugPrint('Token, username o idUsuario faltante');
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // <--- ¡Importante!
    context.read<ChatBloc>().add(DesconectarChatEvent());
    super.dispose();
  }

  String generarKey(Mensaje msg) {
    if (msg.idTemporal != null) return msg.idTemporal!;
    if (msg.id != null) return 'id_${msg.id}';
    return '${msg.texto}_${msg.fecha?.millisecondsSinceEpoch}_${msg.emisor}';
  }

  void agregarMensajeSinDuplicados(Map<String, Mensaje> map, Mensaje msg) {
    String? matchKey;

    // 1. Buscar por ID persistente si existe
    if (msg.id != null) {
      matchKey = map.entries.firstWhere(
            (e) => e.value.id == msg.id,
        orElse: () => MapEntry('', Mensaje.vacio()),
      ).key;

      if (matchKey != '') {
        final existente = map[matchKey]!;
        if (_estadoValor(msg.estado) >= _estadoValor(existente.estado)) {
          map[matchKey] = msg.copyWith(
            fecha: msg.fecha ?? existente.fecha,
            texto: msg.texto ?? existente.texto,
            archivo: msg.archivo ?? existente.archivo,
          );
        }
        return;
      }
    }

    // 2. Buscar por ID temporal si existe
    if (msg.idTemporal != null) {
      matchKey = map.entries.firstWhere(
            (e) => e.value.idTemporal == msg.idTemporal,
        orElse: () => MapEntry('', Mensaje.vacio()),
      ).key;

      if (matchKey != '') {
        final existente = map[matchKey]!;
        if (_estadoValor(msg.estado) >= _estadoValor(existente.estado)) {
          map[matchKey] = msg.copyWith(
            fecha: msg.fecha ?? existente.fecha,
            texto: msg.texto ?? existente.texto,
            archivo: msg.archivo ?? existente.archivo,
          );
        }
        return;
      }
    }

    // 3. Buscar por coincidencia aproximada
    for (var entry in map.entries) {
      final m = entry.value;
      final esCoincidente = m.emisor == msg.emisor &&
          m.receptor == msg.receptor &&
          m.texto == msg.texto &&
          m.tipo == msg.tipo &&
          m.fecha != null &&
          msg.fecha != null &&
          (m.fecha!.difference(msg.fecha!).inSeconds).abs() < 20;

      if (esCoincidente) {
        if (_estadoValor(msg.estado) > _estadoValor(m.estado)) {
          map[entry.key] = msg;
        }
        return;
      }
    }

    // 4. Agregar si no se encontró coincidencia
    map[generarKey(msg)] = msg;
  }

  void enviarMensajeTexto(String contenido) {
    if (contenido.isEmpty || emisor == null || widget.username == null) return;

    final uuid = Uuid();

    final mensaje = Mensaje(
      idTemporal: uuid.v4(),
      emisor: emisor!,
      receptor: widget.username!,
      texto: contenido,
      archivo: null,
      estado: "ENVIADO",
      tipo: "TEXTO",
      fecha: DateTime.now(),
    );

    context.read<ChatBloc>().add(EnviarMensajeEvent(mensaje));
    _controller.clear();
    _scrollAlFinalConReintento();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      }
    });
  }

  String _emojiEstado(String? estado) {
    switch (estado) {
      case 'PENDIENTE':
        return '🕓 Pendiente';
      case 'ENVIADO':
        return '📤 Enviado';
      case 'ENTREGADO':
        return '📬 Entregado';
      case 'LEIDO':
        return '✅ Leído';
      case 'ERROR_ENVIO':
        return '❌ Error';
      default:
        return '';
    }
  }

  Widget _mensajeWidget(Mensaje msg, Color myColor, Color otherColor, Color otherTextoColor) {
    final bool esMio = msg.emisor == emisor;

    if (msg.tipo == 'TEXTO' && (msg.texto == null || msg.texto!.trim().isEmpty)) {
      return const SizedBox.shrink(); // no renderizar
    }

    final hora = msg.fecha != null
        ? DateFormat('h:mm a', 'es')
        .format(msg.fecha!)
        .toLowerCase()
        .replaceAll('am', 'a. m.')
        .replaceAll('pm', 'p. m.')
        : "--:--";

    Widget metadata = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          hora,
          style: esMio
              ? const TextStyle(fontSize: 10, color: Color(0xFFF8F8FF))
              : const TextStyle(fontSize: 10, color: Color(0xFF999999)),
        ),
        const SizedBox(width: 8),
        if (msg.estado != null && esMio)
          Text(
            _emojiEstado(msg.estado),
            style: const TextStyle(fontSize: 10, color: Color(0xFFF8F8FF)),
          ),
      ],
    );

    print("Redibujando mensaje: ${msg.idTemporal ?? msg.id}, estado: ${msg.estado}");

    // AQUÍ pegamos el bloque del switch
    Widget contenidoMensaje;
    switch (msg.tipo) {
      case 'IMAGEN':
        contenidoMensaje = ImagenMensajeWidget(
          nombreArchivo: msg.archivo ?? '',
          esMio: esMio,
          fecha: msg.fecha ?? DateTime.now(),
          estado: msg.estado ?? '',
          myColor: myColor,
          otherColor: otherColor,
          estadoColor: esMio ? Colors.white : otherTextoColor,
        );
        break;

      case 'DOCUMENTO':
        contenidoMensaje = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () => launchUrl(Uri.parse('${ApiConstants.baseUrlDevWebSocket}/${msg.archivo}')),
              child: const Text("📄 Abrir documento"),
            ),
            metadata,
          ],
        );
        break;

      /*case 'AUDIO':
        contenidoMensaje = AudioMensajeWidget(
          url: msg.archivo!,
          esMio: esMio,
          metadata: metadata,
        );
        break;*/
      case 'VIDEO':
        contenidoMensaje = VideoMensajeWidget(
          nombreArchivo: msg.archivo ?? '',
          esMio: esMio,
          fecha: msg.fecha ?? DateTime.now(),
          estado: msg.estado ?? '',
          myColor: myColor,
          otherColor: otherColor,
          estadoColor: esMio ? Colors.white : otherTextoColor,
        );
        break;


      case 'EMOJI':
        contenidoMensaje = Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msg.texto ?? '🙂',
              style: TextStyle(fontSize: 28),
            ),
            metadata,
          ],
        );
        break;

      case 'TEXTO_ARCHIVO':
        contenidoMensaje = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg.texto ?? '',
              style: TextStyle(
                fontSize: 16,
                color: esMio ? Colors.white : otherTextoColor,
              ),
            ),
            const SizedBox(height: 4),
            TextButton(
              onPressed: () => launchUrl(Uri.parse('${ApiConstants.baseUrlDevWebSocket}/${msg.archivo}')),
              child: const Text("📎 Ver archivo adjunto"),
            ),
            metadata,
          ],
        );
        break;

      case 'TEXTO':
      default:
        contenidoMensaje = Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (msg.texto != null)
              Flexible(
                child: Text(
                  msg.texto!,
                  style: TextStyle(
                    fontSize: 16,
                    color: esMio ? Colors.white : otherTextoColor,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            metadata,
          ],
        );
    }

    return Align(
      alignment: esMio ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: esMio ? myColor : otherColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(esMio ? 12 : 0),
            bottomRight: Radius.circular(esMio ? 0 : 12),
          ),
        ),
        child: contenidoMensaje,
      ),
    );
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

  void _scrollAlFinalConReintento([int intentos = 50000]) {
    if (!_scrollController.hasClients) return;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 1000)); // más tiempo para que la imagen se renderice

      if (!_scrollController.hasClients) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final current = _scrollController.offset;

      if ((maxScroll - current).abs() > 50) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);

        // Reintenta solo si aún no llegó al fondo
        if (intentos > 0) {
          _scrollAlFinalConReintento(intentos - 1);
        }
      }
    });
  }

  Widget _buildInputBar(Color barColor, Color fieldColor, Color hintColor, Color backgroundColor, Color myMessageColor) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        color: backgroundColor,
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.emoji_emotions_outlined), onPressed: () {}),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: fieldColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: _controller,
                  style: TextStyle(color: hintColor),
                  decoration: InputDecoration(
                    hintText: "Mensaje",
                    hintStyle: TextStyle(color: hintColor),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) enviarMensajeTexto(value.trim());
                  },
                ),
              ),
            ),
            const SizedBox(width: 6),
            IconButton(icon: const Icon(Icons.attach_file), onPressed: () {}),
            GestureDetector(
              onTap: () async {
                // Capturar imagen
                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(source: ImageSource.camera);

                if (pickedFile != null) {
                  final file = File(pickedFile.path);
                  context.read<FileAdminBloc>().add(
                    UploadFileEvent(file: file, tipo: 'IMAGEN'),
                  );
                }
              },
              onLongPress: () async {
                // Grabar video
                final picker = ImagePicker();
                final pickedFile = await picker.pickVideo(source: ImageSource.camera);

                if (pickedFile != null) {
                  final file = File(pickedFile.path);
                  context.read<FileAdminBloc>().add(
                    UploadFileEvent(file: file, tipo: 'VIDEO'), // Notar tipo VIDEO
                  );
                }
              },
              child: const Icon(Icons.camera_alt),
            ),
            IconButton(icon: const Icon(Icons.mic), onPressed: () {}),
            CircleAvatar(
              backgroundColor: myMessageColor,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  final text = _controller.text.trim();
                  if (text.isNotEmpty) enviarMensajeTexto(text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<LocalThemeProvider>().isDarkMode;
    final theme = isDarkMode ? ThemeData.dark() : ThemeData.light();

    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final myMessageColor = isDarkMode ? const Color(0xFF3A5A98) : const Color(0xFF306CEC);
    final otherMessageColor = isDarkMode ? const Color(0xFF222222) : Colors.white;
    final inputBarColor = isDarkMode ? const Color(0xFF1A1A1A) : Colors.white;
    final inputFieldColor = isDarkMode ? const Color(0xFF2B2B2B) : const Color(0xFFE0E0E0);
    final hintTextColor = isDarkMode ? Colors.grey[400]! : Colors.black54;
    final otherTextoColor = isDarkMode ? Colors.white : Colors.black;
    final fondoImagen = isDarkMode ? 'assets/images/fondoOscuro.png' : 'assets/images/fondo1.png';

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
              onPressed: () => context.read<LocalThemeProvider>().toggle(),
            ),
          ],
          backgroundColor: backgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/admin/chat'),
          ),
          titleSpacing: -10,
          title: Row(
            children: [
              FotoWidget(fileName: widget.chat.avatarUrl ?? "", size: 40),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.chat.nombreCompleto ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const Text("últ. vez hace 5 minutos", style: TextStyle(fontSize: 12)),
                  ],
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      fondoImagen,
                      fit: BoxFit.cover,
                    ),
                  ),
      BlocListener<MensajeAdminBloc, MensajeAdminState>(
        listenWhen: (previous, current) => current is HistorialCargado,
        listener: (context, state) {
          // Esperamos un poco más después de recibir el historial
          if (state is HistorialCargado) {
            _scrollAlFinalConReintento();
          }
        },
        child: BlocSelector<MensajeAdminBloc, MensajeAdminState, List<Mensaje>>(
          selector: (state) {
            if (state is HistorialCargado) {
              // Convertir DTOs a Mensajes
              return state.mensajes
                  .map((dto) => dto.toEntity())
                  .whereType<Mensaje>()
                  .toList();
            }
            return [];
          },
          builder: (context, historialMensajes) {
            return BlocBuilder<ChatBloc, ChatState>(
              builder: (context, chatState) {
                // Combinar historial + mensajes del tiempo real
                List<Mensaje> todosLosMensajes = [];
                if (chatState is ChatMensajesEstado) {
                  todosLosMensajes.addAll(chatState.mensajes);
                }
                todosLosMensajes.addAll(historialMensajes);


                // Filtrar duplicados
                final Map<String, Mensaje> mensajeMap = {};
                for (var m in todosLosMensajes) {
                  agregarMensajeSinDuplicados(mensajeMap, m);
                }

                print('Mensajes combinados finales:');
                mensajeMap.forEach((k, m) {
                  print('${m.texto} - estado: ${m.estado}');
                });

                final mensajesOrdenados = mensajeMap.values.toList()
                  ..sort((a, b) => a.fecha!.compareTo(b.fecha!));

                // Desplazar hacia abajo si el último mensaje es del receptor
                if (mensajesOrdenados.isNotEmpty) {
                  final ultimo = mensajesOrdenados.last;

                  if (ultimo.emisor != emisor) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_scrollController.hasClients) {
                        _scrollController.jumpTo(
                          _scrollController.position.maxScrollExtent,
                        );
                      }
                    });
                  }
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: mensajesOrdenados.length,
                  itemBuilder: (context, index) {

                    final mensaje = mensajesOrdenados[index];
                    return KeyedSubtree(
                      key: ValueKey(mensaje.idTemporal ?? mensaje.id ?? index),
                      child: _mensajeWidget(
                        mensaje,
                        myMessageColor,
                        otherMessageColor,
                        otherTextoColor,
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
                ],
              ),
            ),
            BlocListener<FileAdminBloc, FileAdminState>(
              listener: (context, state) {
                if (state is FileUploadSuccess && emisor != null && widget.username != null) {
                  final uuid = Uuid();

                  final mensaje = Mensaje(
                    idTemporal: uuid.v4(),
                    emisor: emisor!,
                    receptor: widget.username!,
                    texto: null,
                    archivo: state.fileName,
                    estado: "ENVIADO",
                    tipo: state.tipoArchivo, // <-- tipo dinámico
                    fecha: DateTime.now(),
                  );

                  context.read<ChatBloc>().add(EnviarMensajeEvent(mensaje));
                  _scrollAlFinalConReintento();
                }

                if (state is FileAdminError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al subir archivo: ${state.message}')),
                  );
                }
              },
              child: _buildInputBar(
                inputBarColor,
                inputFieldColor,
                hintTextColor,
                backgroundColor,
                myMessageColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}