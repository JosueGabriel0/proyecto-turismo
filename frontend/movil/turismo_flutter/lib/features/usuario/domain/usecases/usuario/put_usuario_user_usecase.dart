import 'dart:io';

import 'package:turismo_flutter/features/usuario/data/models/usuario_dto_user.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';
import 'package:turismo_flutter/features/usuario/domain/repositories/usuario_user_repository.dart';

class PutUsuarioUserUseCase {
  final UsuarioUserRepository repository;

  PutUsuarioUserUseCase(this.repository);

  Future<UsuarioUserResponse> call(int id, UsuarioDtoUser usuario, File? imagen) {
    return repository.putUsuarioCompleto(id, usuario, imagen);
  }
}