import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/emprendimiento_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/emprendimiento_repository.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/emprendimiento_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/emprendimiento_general_repository.dart';

class EmprendimientoGeneralRepositoryImpl implements EmprendimientoGeneralRepository {
  final EmprendimientoGeneralApiClient emprendimientoApiClient;

  EmprendimientoGeneralRepositoryImpl(this.emprendimientoApiClient);

  @override
  Future<List<EmprendimientoGeneralResponse>> getEmprendimientosGeneral() {
    return emprendimientoApiClient.getEmprendimientos();
  }

  @override
  Future<EmprendimientoGeneralResponse> getEmprendimientoById(int idEmprendimiento) {
    return emprendimientoApiClient.getEmprendimientoById(idEmprendimiento);
  }

  @override
  Future<List<EmprendimientoGeneralResponse>> buscarEmprendimientosPorNombreGeneral(String nombre) {
    return emprendimientoApiClient.buscarEmprendimientosPorNombre(nombre);
  }
}