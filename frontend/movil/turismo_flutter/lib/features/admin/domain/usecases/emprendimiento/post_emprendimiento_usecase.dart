import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/emprendimiento_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/emprendimiento_repository.dart';

class PostEmprendimientoUsecase {
  final EmprendimientoRepository emprendimientoRepository;
  PostEmprendimientoUsecase(this.emprendimientoRepository);

  Future<EmprendimientoResponse> call(EmprendimientoDto emprendimientoDto, File? file) async {
    return await emprendimientoRepository.postEmprendimiento(emprendimientoDto, file);
  }
}
