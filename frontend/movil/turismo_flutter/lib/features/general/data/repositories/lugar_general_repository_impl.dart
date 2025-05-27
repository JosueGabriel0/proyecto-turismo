import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/lugar_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/lugar_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/models/familia_general_response.dart';
import 'package:turismo_flutter/features/general/data/models/lugar_general_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/lugar_general_respository.dart';

class LugarGeneralRepositoryImpl implements LugarGeneralRespository {
  final LugarGeneralApiClient lugarApiClient;

  LugarGeneralRepositoryImpl(this.lugarApiClient);

  @override
  Future<List<LugarGeneralResponse>> getLugaresGeneral() {
    return lugarApiClient.getLugares();
  }

  @override
  Future<List<LugarGeneralResponse>> buscarLugaresPorNombreGeneral(String nombre) {
    return lugarApiClient.buscarLugaresPorNombre(nombre);
  }

  @override
  Future<List<FamiliaGeneralResponse>> getFamiliasPorLugar(int idLugar, String? nombre) {
    return lugarApiClient.getFamiliasPorLugar(idLugar, nombre);
  }
}