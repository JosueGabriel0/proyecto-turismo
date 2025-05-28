import 'package:turismo_flutter/features/emprendedor/data/models/emprendimiento_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/emprendimiento_emprendedor_repository.dart';

class GetEmprendimientoByIdUsuarioEmprendedorUsecase {
  final EmprendimientoEmprendedorRepository repository;

  GetEmprendimientoByIdUsuarioEmprendedorUsecase(this.repository);

  Future<EmprendimientoEmprendedorResponse> call(int idUsuario) {
    return repository.getEmprendimientoByIdUsuario(idUsuario);
  }
}
