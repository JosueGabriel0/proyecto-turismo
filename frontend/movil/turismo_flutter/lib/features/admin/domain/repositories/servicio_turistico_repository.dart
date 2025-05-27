import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_response.dart';

abstract class ServicioTuristicoRepository {
  Future<List<ServicioTuristicoResponse>> getServicioTuristico();
  Future<ServicioTuristicoResponse> getServicioTuristicoById(int id);
  Future<ServicioTuristicoResponse> postServicioTuristico(ServicioTuristicoDto servicioTuristico, File? imagen);
  Future<ServicioTuristicoResponse> putServicioTuristico(int id, ServicioTuristicoDto servicioTuristico, File? imagen);
  Future<void> deleteServicioTuristico(int id);
  Future<List<ServicioTuristicoResponse>> buscarServicioTuristicosPorNombre(String nombre);
}