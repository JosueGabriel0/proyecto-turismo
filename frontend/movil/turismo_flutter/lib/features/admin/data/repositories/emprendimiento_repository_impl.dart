import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/emprendimiento_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/emprendimiento_repository.dart';

class EmprendimientoRepositoryImpl implements EmprendimientoRepository {
  final EmprendimientoApiClient emprendimientoApiClient;

  EmprendimientoRepositoryImpl(this.emprendimientoApiClient);

  @override
  Future<void> deleteEmprendimiento(int idEmprendimiento) {
    return emprendimientoApiClient.deleteEmprendimiento(idEmprendimiento);
  }

  @override
  Future<EmprendimientoResponse> getEmprendimientoById(int idEmprendimiento) {
    return emprendimientoApiClient.getEmprendimientoById(idEmprendimiento);
  }

  @override
  Future<List<EmprendimientoResponse>> getEmprendimientos() {
    return emprendimientoApiClient.getEmprendimientos();
  }

  @override
  Future<EmprendimientoResponse> postEmprendimiento(EmprendimientoDto emprendimientoDto, File? file) async {
    final emprendimientoJson = jsonEncode(emprendimientoDto.toJson());
    MultipartFile? multipartFile;
    if(file != null){
      multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"),
      );
    }
    return emprendimientoApiClient.postEmprendimiento(emprendimientoJson, multipartFile);
  }

  @override
  Future<EmprendimientoResponse> putEmprendimiento(int idEmprendimiento, EmprendimientoDto emprendimientoDto, File? file) async {
    final emprendimientoJson = jsonEncode(emprendimientoDto.toJson());
    MultipartFile? multipartFile;
    if(file != null){
      multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"),
      );
    }
    return emprendimientoApiClient.putEmprendimiento(idEmprendimiento, emprendimientoJson, multipartFile);
  }

  @override
  Future<List<EmprendimientoResponse>> buscarEmprendimientosPorNombre(String nombre) {
    return emprendimientoApiClient.buscarEmprendimientosPorNombre(nombre);
  }
}