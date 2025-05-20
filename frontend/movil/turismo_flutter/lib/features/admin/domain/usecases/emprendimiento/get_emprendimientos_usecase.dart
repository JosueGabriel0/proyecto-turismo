import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/emprendimiento_repository.dart';

class GetEmprendimientosUsecase {
  final EmprendimientoRepository emprendimientoRepository;
  GetEmprendimientosUsecase(this.emprendimientoRepository);

  Future<List<EmprendimientoResponse>> call() async {
    return await emprendimientoRepository.getEmprendimientos();
  }
}
