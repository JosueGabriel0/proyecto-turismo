import 'dart:io';

import 'package:turismo_flutter/features/emprendedor/data/models/emprendimiento_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/emprendimiento_emprendedor_response.dart';

abstract class EmprendimientoEmprendedorRepository {
  Future<EmprendimientoEmprendedorResponse> getEmprendimientoByIdUsuario(int idUsuario,);

  Future<EmprendimientoEmprendedorResponse> updateEmprendimiento(int idEmprendimiento, EmprendimientoEmprendedorDto emprendimientoEmprendedorDto, File? file,);
}