import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/usuario_completo_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/usuario_repository.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_dto.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';
import 'package:turismo_flutter/features/usuario/domain/repositories/usuario_user_repository.dart';

class PutUsuarioUserUseCase {
  final UsuarioUserRepository repository;

  PutUsuarioUserUseCase(this.repository);

  Future<UsuarioUserResponse> call(int id, UsuarioUserDto usuario, File? imagen) {
    return repository.putUsuarioCompleto(id, usuario, imagen);
  }
}