import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/usuario_repository.dart';

class GetUsuarioByIdUseCase {
  final UsuarioRepository repository;

  GetUsuarioByIdUseCase(this.repository);

  Future<UsuarioCompletoResponse> call(int id) {
    return repository.getUsuarioCompletoById(id);
  }
}
