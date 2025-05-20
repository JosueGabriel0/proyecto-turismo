import 'dart:io';

import 'package:dio/dio.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';

abstract class EmprendimientoRepository {
  Future<List<EmprendimientoResponse>> getEmprendimientos();
  Future<EmprendimientoResponse> getEmprendimientoById(int idEmprendimiento);
  Future<EmprendimientoResponse> postEmprendimiento(EmprendimientoDto emprendimientoDto, File? file);
  Future<EmprendimientoResponse> putEmprendimiento(int idEmprendimiento, EmprendimientoDto emprendimientoDto, File? file);
  Future<void> deleteEmprendimiento(int idEmprendimiento);
  Future<List<EmprendimientoResponse>> buscarEmprendimientosPorNombre(String nombre);
}
