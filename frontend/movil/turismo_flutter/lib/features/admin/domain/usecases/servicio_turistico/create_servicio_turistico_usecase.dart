import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/lugar_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/servicio_turistico_repository.dart';

class CreateServicioTuristicoUsecase{
  final ServicioTuristicoRepository servicioTuristicoRepository;

  CreateServicioTuristicoUsecase(this.servicioTuristicoRepository);

  Future<ServicioTuristicoResponse> call(ServicioTuristicoDto servicioTuristicoDto, File? imagen) async {
    return await servicioTuristicoRepository.postServicioTuristico(servicioTuristicoDto, imagen);
  }
}