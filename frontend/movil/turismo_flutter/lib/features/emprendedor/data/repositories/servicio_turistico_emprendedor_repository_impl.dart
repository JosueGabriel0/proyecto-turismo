import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:turismo_flutter/features/emprendedor/data/datasources/remote/servicio_turistico_emprendedor_api_client.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/servicio_turistico_emprendedor_repository.dart';

class ServicioTuristicoEmprendedorRepositoryImpl implements ServicioTuristicoEmprendedorRepository {
  final ServicioTuristicoEmprendedorApiClient servicioTuristicoEmprendedorApiClient;

  ServicioTuristicoEmprendedorRepositoryImpl(this.servicioTuristicoEmprendedorApiClient);

  @override
  Future<List<ServicioTuristicoEmprendedorResponse>> buscarServiciosTuristicosPorNombre(String nombre) {
    return servicioTuristicoEmprendedorApiClient.buscarServiciosTuristicosPorNombre(nombre);
  }

  @override
  Future<void> deleteServicioTuristico(int idServicio) {
    return servicioTuristicoEmprendedorApiClient.deleteServicioTuristico(idServicio);
  }

  @override
  Future<ServicioTuristicoEmprendedorResponse> getServicioTuristicoById(int idServicio) {
    return servicioTuristicoEmprendedorApiClient.getServicioTuristicoById(idServicio);
  }

  @override
  Future<List<ServicioTuristicoEmprendedorResponse>> getServicioTuristicosPorIdEmprendimiento(int idEmprendimiento) {
    return servicioTuristicoEmprendedorApiClient.getServicioTuristicosPorIdEmprendimiento(idEmprendimiento);
  }

  @override
  Future<ServicioTuristicoEmprendedorResponse> postServicioTuristico(ServicioTuristicoEmprendedorDto servicioTuristicoEmprendedorDto, File? file) async {
    final servicioTuristicoJson = jsonEncode(servicioTuristicoEmprendedorDto.toJson());
    MultipartFile? multipartFile;

    if(file != null){
      multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"),
      );
    }
    return servicioTuristicoEmprendedorApiClient.postServicioTuristico(servicioTuristicoJson, multipartFile);
  }

  @override
  Future<ServicioTuristicoEmprendedorResponse> putServicioTuristico(int idServicio, ServicioTuristicoEmprendedorDto servicioTuristicoEmprendedorDto, File? file) async {
    final servicioTuristicoJson = jsonEncode(servicioTuristicoEmprendedorDto.toJson());
    MultipartFile? multipartFile;

    if(file != null){
      multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"),
      );
    }
    return servicioTuristicoEmprendedorApiClient.putServicioTuristico(idServicio, servicioTuristicoJson, multipartFile);
  }
}