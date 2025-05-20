import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/lugar_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';

class LugarRepositoryImpl implements LugarRepository {
  final LugarApiClient lugarApiClient;

  LugarRepositoryImpl(this.lugarApiClient);

  @override
  Future<void> deleteLugar(int id) {
    return lugarApiClient.deleteLugar(id);
  }

  @override
  Future<LugarResponse> getLugarById(int id) {
    return lugarApiClient.getLugarById(id);
  }

  @override
  Future<List<LugarResponse>> getLugares() {
    return lugarApiClient.getLugares();
  }

  @override
  Future<LugarResponse> postLugar(LugarDto lugar, File? imagen) async{
    final lugarJson = jsonEncode(lugar.toJson());
    MultipartFile? multipartFile;

    if(imagen != null){
      multipartFile = await MultipartFile.fromFile(
          imagen.path,
          filename: imagen.uri.pathSegments.last,
          contentType: MediaType("image", "jpeg"),
      );
    }

    return lugarApiClient.postLugar(lugarJson, multipartFile);
  }

  @override
  Future<LugarResponse> putLugar(int id, LugarDto lugar, File? imagen) async {
    final lugarJson = jsonEncode(lugar.toJson());
    MultipartFile? multipartFile;

    if(imagen != null){
      multipartFile = await MultipartFile.fromFile(
        imagen.path,
        filename: imagen.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"),
      );
    }
    return lugarApiClient.putLugar(id, lugarJson, multipartFile);
  }

  @override
  Future<List<LugarResponse>> buscarLugaresPorNombre(String nombre) {
    return lugarApiClient.buscarLugaresPorNombre(nombre);
  }
}