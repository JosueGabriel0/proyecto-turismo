import '../repositories/chat_repository.dart';

class MarcarComoLeido {
  final ChatRepository repository;

  MarcarComoLeido(this.repository);

  void call({
    required String emisor,
    required String receptor,
  }) {
    repository.marcarComoLeido(emisor: emisor, receptor: receptor);
  }
}
