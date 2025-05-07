import 'package:turismo_flutter/features/admin/domain/repositories/usuario_repository.dart';

class DeleteUsuarioUseCase {
  final UsuarioRepository repository;

  DeleteUsuarioUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deleteUsuarioCompleto(id);
  }
}
