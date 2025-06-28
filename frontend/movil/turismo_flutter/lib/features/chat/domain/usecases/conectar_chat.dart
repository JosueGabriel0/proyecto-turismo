import '../repositories/chat_repository.dart';

class ConectarChat {
  final ChatRepository repository;

  ConectarChat(this.repository);

  void call() {
    repository.conectar();
  }
}
