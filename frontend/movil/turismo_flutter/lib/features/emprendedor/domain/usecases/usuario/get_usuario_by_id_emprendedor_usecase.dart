import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/usuario_repository.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/usuario_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/usuario_emprendedor_repository.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';
import 'package:turismo_flutter/features/usuario/domain/repositories/usuario_user_repository.dart';

class GetUsuarioByIdEmprendedorUsecase {
  final UsuarioEmprendedorRepository repository;

  GetUsuarioByIdEmprendedorUsecase(this.repository);

  Future<UsuarioEmprendedorResponse> call(int id) {
    return repository.getUsuarioCompletoById(id);
  }
}
