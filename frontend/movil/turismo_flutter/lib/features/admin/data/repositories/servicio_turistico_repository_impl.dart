import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/servicio_turistico_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/servicio_turistico_repository.dart';

class ServicioTuristicoRepositoryImpl implements ServicioTuristicoRepository{
  final ServicioTuristicoApiClient servicioTuristicoApiClient;

  ServicioTuristicoRepositoryImpl(this.servicioTuristicoApiClient);

  @override
  Future<List<ServicioTuristicoResponse>> buscarServicioTuristicosPorNombre(String nombre) {
    return servicioTuristicoApiClient.buscarLugaresPorNombre(nombre);
  }

  @override
  Future<void> deleteServicioTuristico(int id) {
    return servicioTuristicoApiClient.deleteServicioTuristico(id);
  }

  @override
  Future<List<ServicioTuristicoResponse>> getServicioTuristico() {
    return servicioTuristicoApiClient.getServicioTuristico();
  }

  @override
  Future<ServicioTuristicoResponse> getServicioTuristicoById(int id) {
    return servicioTuristicoApiClient.getServicioTuristicoById(id);
  }

  @override
  Future<ServicioTuristicoResponse> postServicioTuristico(ServicioTuristicoDto servicioTuristico, File? imagen) async {
    final servicioTuristicoJson = jsonEncode(servicioTuristico.toJson());
    MultipartFile? multipartFile;

    if(imagen != null){
      multipartFile = await MultipartFile.fromFile(
        imagen.path,
        filename: imagen.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"),
      );
    }
    return servicioTuristicoApiClient.postServicioTuristico(servicioTuristicoJson, multipartFile);
  }

  @override
  Future<ServicioTuristicoResponse> putServicioTuristico(int id, ServicioTuristicoDto servicioTuristico, File? imagen) async {
    final servicioTuristicoJson = jsonEncode(servicioTuristico.toJson());
    MultipartFile? multipartFile;

    if(imagen != null){
      multipartFile = await MultipartFile.fromFile(
        imagen.path,
        filename: imagen.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"),
      );
    }
    return servicioTuristicoApiClient.putServicioTuristico(id, servicioTuristicoJson, multipartFile);
  }
}