import '../repositories/chat_repository.dart';

class MarcarComoEntregado {
  final ChatRepository repository;

  MarcarComoEntregado(this.repository);

  void call({
    required String emisor,
    required String receptor,
  }) {
    repository.marcarComoEntregado(emisor: emisor, receptor: receptor);
  }
}
