import '../entities/mensaje.dart';

abstract class ChatRepository {
  void conectar();
  void desconectar();

  void enviarMensaje(Mensaje mensaje);
  void editarMensaje(Mensaje mensaje);

  void marcarComoEntregado({
    required String emisor,
    required String receptor,
  });

  void marcarComoLeido({
    required String emisor,
    required String receptor,
  });
}