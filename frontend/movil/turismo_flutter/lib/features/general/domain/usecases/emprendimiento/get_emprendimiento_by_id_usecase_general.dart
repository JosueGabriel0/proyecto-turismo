import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/emprendimiento_repository.dart';
import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/emprendimiento_general_repository.dart';

class GetEmprendimientoByIdUsecaseGeneral {
  final EmprendimientoGeneralRepository emprendimientoGeneralRepository;
  GetEmprendimientoByIdUsecaseGeneral(this.emprendimientoGeneralRepository);

  Future<EmprendimientoGeneralResponse> call(int idEmprendimiento) async {
    return await emprendimientoGeneralRepository.getEmprendimientoById(idEmprendimiento);
  }
}