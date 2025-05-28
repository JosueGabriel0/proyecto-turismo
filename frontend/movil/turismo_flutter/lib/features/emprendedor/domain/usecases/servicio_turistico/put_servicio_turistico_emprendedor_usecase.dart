import 'dart:io';

import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/servicio_turistico_emprendedor_repository.dart';

class PutServicioTuristicoEmprendedorUsecase {
  final ServicioTuristicoEmprendedorRepository repository;

  PutServicioTuristicoEmprendedorUsecase(this.repository);

  Future<ServicioTuristicoEmprendedorResponse> call(int idServicio, ServicioTuristicoEmprendedorDto dto, File? file) {
    return repository.putServicioTuristico(idServicio, dto, file);
  }
}
