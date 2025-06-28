import '../repositories/chat_repository.dart';

class DesconectarChat {
  final ChatRepository repository;

  DesconectarChat(this.repository);

  void call() {
    repository.desconectar();
  }
}
