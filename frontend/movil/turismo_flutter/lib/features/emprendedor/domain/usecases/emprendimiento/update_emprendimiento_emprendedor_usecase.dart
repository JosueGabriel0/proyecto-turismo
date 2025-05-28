import 'dart:io';

import 'package:turismo_flutter/features/emprendedor/data/models/emprendimiento_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/emprendimiento_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/emprendimiento_emprendedor_repository.dart';

class UpdateEmprendimientoEmprendedorUsecase {
  final EmprendimientoEmprendedorRepository repository;

  UpdateEmprendimientoEmprendedorUsecase(this.repository);

  Future<EmprendimientoEmprendedorResponse> call({
    required int idEmprendimiento,
    required EmprendimientoEmprendedorDto dto,
    File? imageFile,
  }) {
    return repository.updateEmprendimiento(idEmprendimiento, dto, imageFile);
  }
}