import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/familia_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_repository.dart';

class FamiliaRepositoryImpl implements FamiliaRepository {
  final FamiliaApiClient familiaApiClient;

  FamiliaRepositoryImpl(this.familiaApiClient);

  @override
  Future<void> deleteFamilia(int idFamilia) {
    return familiaApiClient.deleteFamilia(idFamilia);
  }

  @override
  Future<FamiliaResponse> getFamiliaById(int idFamilia) {
    return familiaApiClient.getFamiliaById(idFamilia);
  }

  @override
  Future<List<FamiliaResponse>> getFamilias() {
    return familiaApiClient.getFamilias();
  }

  @override
  Future<FamiliaResponse> postFamilia(FamiliaDto familiaDto, File? file) async {
    final familiaJson = jsonEncode(familiaDto.toJson());
    MultipartFile? multipartFile;
    if(file != null){
      multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"),
      );
    }
    return familiaApiClient.postFamilia(familiaJson, multipartFile);
  }

  @override
  Future<FamiliaResponse> putFamilia(int idFamilia, FamiliaDto familiaDto, File? file) async {
    final familiaJson = jsonEncode(familiaDto.toJson());
    MultipartFile? multipartFile;
    if(file != null){
      multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg")
      );
    }
    return familiaApiClient.putFamilia(idFamilia, familiaJson, multipartFile);
  }

  @override
  Future<List<FamiliaResponse>> buscarFamiliasPorNombre(String nombre) {
    return familiaApiClient.buscarFamiliasPorNombre(nombre);
  }
}