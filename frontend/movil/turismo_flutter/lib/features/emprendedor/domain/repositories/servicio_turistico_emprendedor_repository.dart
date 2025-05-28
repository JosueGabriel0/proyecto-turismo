import 'dart:io';

import 'package:dio/dio.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_response.dart';

abstract class ServicioTuristicoEmprendedorRepository {
  Future<List<ServicioTuristicoEmprendedorResponse>> getServicioTuristicosPorIdEmprendimiento(int IdEmprendimiento);
  Future<ServicioTuristicoEmprendedorResponse> getServicioTuristicoById(int idServicio);
  Future<ServicioTuristicoEmprendedorResponse> postServicioTuristico(ServicioTuristicoEmprendedorDto servicioTuristicoEmprendedorDto, File? file,);
  Future<ServicioTuristicoEmprendedorResponse> putServicioTuristico(int idServicio, ServicioTuristicoEmprendedorDto servicioTuristicoEmprendedorDto, File? file,);
  Future<void> deleteServicioTuristico(int idServicio);
  Future<List<ServicioTuristicoEmprendedorResponse>> buscarServiciosTuristicosPorNombre(String nombre,);
}
