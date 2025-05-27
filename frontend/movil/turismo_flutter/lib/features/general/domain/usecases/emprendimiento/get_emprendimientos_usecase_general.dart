import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/emprendimiento_repository.dart';
import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/emprendimiento_general_repository.dart';

class GetEmprendimientosUsecaseGeneral {
  final EmprendimientoGeneralRepository emprendimientoGeneralRepository;
  GetEmprendimientosUsecaseGeneral(this.emprendimientoGeneralRepository);

  Future<List<EmprendimientoGeneralResponse>> call() async {
    return await emprendimientoGeneralRepository.getEmprendimientosGeneral();
  }
}
