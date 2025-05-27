import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/servicio_turistico_repository.dart';

class GetServicioTuristicoByIdUsecase {
  final ServicioTuristicoRepository servicioTuristicoRepository;

  GetServicioTuristicoByIdUsecase(this.servicioTuristicoRepository);

  Future<ServicioTuristicoResponse> call(int id) async {
    return servicioTuristicoRepository.getServicioTuristicoById(id);
  }
}