import 'package:turismo_flutter/features/chat/data/datasources/remote/chat_websocket_datasource.dart';
import 'package:turismo_flutter/features/chat/domain/entities/mensaje.dart';
import 'package:turismo_flutter/features/chat/domain/repositories/chat_repository.dart';
import 'package:turismo_flutter/features/chat/data/mappers/mensaje_mapper.dart';


class ChatRepositoryImpl implements ChatRepository {
  final ChatWebSocketDatasource datasource;

  ChatRepositoryImpl(this.datasource);

  @override
  void conectar() {
    datasource.connect();
  }

  @override
  void desconectar() {
    datasource.disconnect();
  }

  @override
  void enviarMensaje(Mensaje mensaje) {
    datasource.enviarMensaje(mensaje.toDto());
  }

  @override
  void editarMensaje(Mensaje mensaje) {
    datasource.editarMensaje(mensaje.toDto());
  }

  @override
  void marcarComoEntregado({
    required String emisor,
    required String receptor,
  }) {
    datasource.marcarEntregado(emisor, receptor);
  }

  @override
  void marcarComoLeido({
    required String emisor,
    required String receptor,
  }) {
    datasource.marcarLeido(emisor, receptor);
  }
}