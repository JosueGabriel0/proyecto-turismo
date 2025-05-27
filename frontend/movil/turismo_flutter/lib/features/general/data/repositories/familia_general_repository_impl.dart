import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/familia_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_repository.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/familia_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/models/familia_general_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/familia_general_repository.dart';

class FamiliaGeneralRepositoryImpl implements FamiliaGeneralRepository {
  final FamiliaGeneralApiClient familiaApiClient;

  FamiliaGeneralRepositoryImpl(this.familiaApiClient);

  @override
  Future<FamiliaGeneralResponse> getFamiliaByIdGeneral(int idFamilia) {
    return familiaApiClient.getFamiliaById(idFamilia);
  }

  @override
  Future<List<FamiliaGeneralResponse>> getFamiliasGeneral() {
    return familiaApiClient.getFamilias();
  }

  @override
  Future<List<FamiliaGeneralResponse>> buscarFamiliasPorNombreGeneral(String nombre) {
    return familiaApiClient.buscarFamiliasPorNombre(nombre);
  }
}