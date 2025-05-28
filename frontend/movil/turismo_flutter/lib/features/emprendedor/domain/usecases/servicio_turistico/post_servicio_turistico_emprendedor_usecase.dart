import 'dart:io';

import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/servicio_turistico_emprendedor_repository.dart';

class PostServicioTuristicoEmprendedorUsecase {
  final ServicioTuristicoEmprendedorRepository repository;

  PostServicioTuristicoEmprendedorUsecase(this.repository);

  Future<ServicioTuristicoEmprendedorResponse> call(ServicioTuristicoEmprendedorDto dto, File? file) {
    return repository.postServicioTuristico(dto, file);
  }
}