import 'dart:convert';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:turismo_flutter/features/chat/data/models/mensaje_dto.dart';

typedef OnMensajeRecibido = void Function(MensajeDto mensaje);
typedef OnEstadoMensaje = void Function(MensajeDto mensaje);
typedef OnMensajeEditado = void Function(MensajeDto mensaje);

class ChatWebSocketDatasource {
  final String url;
  final String accessToken;
  StompClient? _client;

  late OnMensajeRecibido onMensajeRecibido;
  late OnEstadoMensaje onEstadoMensaje;
  late OnMensajeEditado onMensajeEditado;

  ChatWebSocketDatasource({
    required this.url,
    required this.accessToken,
    required this.onMensajeRecibido,
    required this.onEstadoMensaje,
    required this.onMensajeEditado,
  });

  void connect() {
    _client = StompClient(
      config: StompConfig(
        url: '${url}/ws-chat?token=$accessToken', // Token en la URL
        onConnect: _onConnect,
        onWebSocketError: (error) => print('❌ WebSocket error: $error'),
        onStompError: (frame) => print('❌ STOMP error: ${frame.body}'),
        onDisconnect: (_) => print('🔌 Desconectado del WebSocket'),
        onDebugMessage: (msg) => print('🐛 STOMP Debug: $msg'),
      ),
    );

    _client!.activate();
  }

  void _onConnect(StompFrame frame) {
    print('✅ Conectado al WebSocket');

    // Escuchar mensajes nuevos
    _client!.subscribe(
      destination: '/user/queue/mensajes',
      callback: (frame) {
        final data = jsonDecode(frame.body!);
        final mensaje = MensajeDto.fromJson(data);
        onMensajeRecibido(mensaje);
      },
    );

    // Escuchar cambios de estado: ENVIADO, ENTREGADO, LEIDO, ERROR_ENVIO
    _client!.subscribe(
      destination: '/user/queue/estado',
      callback: (frame) {
        final data = jsonDecode(frame.body!);
        final mensaje = MensajeDto.fromJson(data);
        onEstadoMensaje(mensaje);
      },
    );

    // Escuchar mensajes editados
    _client!.subscribe(
      destination: '/user/queue/mensaje-editado',
      callback: (frame) {
        final data = jsonDecode(frame.body!);
        final mensaje = MensajeDto.fromJson(data);
        onMensajeEditado(mensaje);
      },
    );
  }

  void enviarMensaje(MensajeDto mensaje) {
    _client?.send(
      destination: '/app/chat/enviar',
      body: jsonEncode(mensaje.toJson()),
    );
  }

  void marcarEntregado(String emisorUsername, String receptorUsername) {
    _client?.send(
      destination: '/app/chat/marcar-entregado',
      body: jsonEncode({
        'emisorUsername': emisorUsername,
        'receptorUsername': receptorUsername,
      }),
    );
  }

  void marcarLeido(String emisorUsername, String receptorUsername) {
    _client?.send(
      destination: '/app/chat/marcar-leido',
      body: jsonEncode({
        'emisorUsername': emisorUsername,
        'receptorUsername': receptorUsername,
      }),
    );
  }

  void editarMensaje(MensajeDto mensaje) {
    _client?.send(
      destination: '/app/chat/editar',
      body: jsonEncode(mensaje.toJson()),
    );
  }

  void disconnect() {
    _client?.deactivate();
  }
}