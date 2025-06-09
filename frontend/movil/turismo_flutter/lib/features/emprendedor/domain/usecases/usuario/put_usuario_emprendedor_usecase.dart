import 'dart:io';

import 'package:turismo_flutter/features/emprendedor/data/models/usuario_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/usuario_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/usuario_emprendedor_repository.dart';

class PutUsuarioEmprendedorUsecase {
  final UsuarioEmprendedorRepository repository;

  PutUsuarioEmprendedorUsecase(this.repository);

  Future<UsuarioEmprendedorResponse> call(int id, UsuarioEmprendedorDto usuario, File? imagen) {
    return repository.putUsuarioCompleto(id, usuario, imagen);
  }
}