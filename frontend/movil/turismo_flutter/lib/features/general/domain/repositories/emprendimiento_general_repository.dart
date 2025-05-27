import 'dart:io';

import 'package:dio/dio.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';

abstract class EmprendimientoGeneralRepository {
  Future<List<EmprendimientoGeneralResponse>> getEmprendimientosGeneral();
  Future<EmprendimientoGeneralResponse> getEmprendimientoById(int idEmprendimiento);
  Future<List<EmprendimientoGeneralResponse>> buscarEmprendimientosPorNombreGeneral(String nombre);
}
