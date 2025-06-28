import '../entities/mensaje.dart';
import '../repositories/chat_repository.dart';

class EnviarMensaje {
  final ChatRepository repository;

  EnviarMensaje(this.repository);

  void call(Mensaje mensaje) {
    repository.enviarMensaje(mensaje);
  }
}
