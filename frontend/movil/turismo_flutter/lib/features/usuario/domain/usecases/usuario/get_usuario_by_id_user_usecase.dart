import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';
import 'package:turismo_flutter/features/usuario/domain/repositories/usuario_user_repository.dart';

class GetUsuarioByIdUserUseCase {
  final UsuarioUserRepository repository;

  GetUsuarioByIdUserUseCase(this.repository);

  Future<UsuarioUserResponse> call(int id) {
    return repository.getUsuarioCompletoById(id);
  }
}
