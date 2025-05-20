import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/emprendimiento_repository.dart';

class GetEmprendimientoByIdUsecase {
  final EmprendimientoRepository emprendimientoRepository;
  GetEmprendimientoByIdUsecase(this.emprendimientoRepository);

  Future<EmprendimientoResponse> call(int idEmprendimiento) async {
    return await emprendimientoRepository.getEmprendimientoById(idEmprendimiento);
  }
}