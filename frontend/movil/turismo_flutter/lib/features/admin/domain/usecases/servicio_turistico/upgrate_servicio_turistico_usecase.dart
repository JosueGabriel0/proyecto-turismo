import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/lugar_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/servicio_turistico_repository.dart';

class UpdateServicioTuristicoUseCase {
  final ServicioTuristicoRepository servicioTuristicoRepository;

  UpdateServicioTuristicoUseCase(this.servicioTuristicoRepository);

  Future<ServicioTuristicoResponse> call(int id, ServicioTuristicoDto servicioTuristicoDto, File? imagen) async {
    return await servicioTuristicoRepository.putServicioTuristico(id, servicioTuristicoDto, imagen);
  }
}