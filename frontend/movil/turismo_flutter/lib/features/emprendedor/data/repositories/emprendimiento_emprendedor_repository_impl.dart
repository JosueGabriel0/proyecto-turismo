import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:turismo_flutter/features/emprendedor/data/datasources/remote/emprendimiento_emprendedor_api_client.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/emprendimiento_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/emprendimiento_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/emprendimiento_emprendedor_repository.dart';

class EmprendimientoEmprendedorRepositoryImpl implements EmprendimientoEmprendedorRepository{
  final EmprendimientoEmprendedorApiClient emprendimientoEmprendedorApiClient;

  const EmprendimientoEmprendedorRepositoryImpl(this.emprendimientoEmprendedorApiClient);

  @override
  Future<EmprendimientoEmprendedorResponse> getEmprendimientoByIdUsuario(int idUsuario) {
    return emprendimientoEmprendedorApiClient.getEmprendimientoByIdUsuario(idUsuario);
  }

  @override
  Future<EmprendimientoEmprendedorResponse> updateEmprendimiento(int idEmprendimiento, EmprendimientoEmprendedorDto emprendimientoEmprendedorDto, File? file) async {
    final emprendimientoEmprendedorJson = jsonEncode(emprendimientoEmprendedorDto.toJson());
    MultipartFile? multipartFile;

    if(file != null){
      multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"),
      );
    }
    return emprendimientoEmprendedorApiClient.updateEmprendimiento(idEmprendimiento, emprendimientoEmprendedorJson, multipartFile);
  }

}