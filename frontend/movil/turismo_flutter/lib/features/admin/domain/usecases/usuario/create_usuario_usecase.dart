import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/usuario_completo_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/usuario_repository.dart';

class CreateUsuarioUseCase {
  final UsuarioRepository repository;

  CreateUsuarioUseCase(this.repository);

  Future<UsuarioCompletoResponse> call(UsuarioCompletoDto usuario, File? imagen) {
    return repository.postUsuarioCompleto(usuario, imagen);
  }
}