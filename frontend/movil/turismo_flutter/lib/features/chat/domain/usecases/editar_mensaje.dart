import '../entities/mensaje.dart';
import '../repositories/chat_repository.dart';

class EditarMensaje {
  final ChatRepository repository;

  EditarMensaje(this.repository);

  void call(Mensaje mensaje) {
    repository.editarMensaje(mensaje);
  }
}
