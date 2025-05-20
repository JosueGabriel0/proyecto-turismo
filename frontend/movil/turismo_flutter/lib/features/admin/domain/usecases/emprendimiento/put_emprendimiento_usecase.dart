import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/emprendimiento_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/emprendimiento_repository.dart';

class PutEmprendimientoUsecase {
  final EmprendimientoRepository emprendimientoRepository;
  PutEmprendimientoUsecase(this.emprendimientoRepository);

  Future<EmprendimientoResponse> call(int idEmprendimiento, EmprendimientoDto emprendimientoDto, File? file) async {
    return await emprendimientoRepository.putEmprendimiento(idEmprendimiento, emprendimientoDto, file);
  }
}
