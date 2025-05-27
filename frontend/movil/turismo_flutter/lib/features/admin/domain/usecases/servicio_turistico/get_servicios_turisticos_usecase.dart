import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/servicio_turistico_repository.dart';

class GetServiciosTuristicosUsecase {
  final ServicioTuristicoRepository servicioTuristicoRepository;

  GetServiciosTuristicosUsecase(this.servicioTuristicoRepository);

  Future<List<ServicioTuristicoResponse>> call() async {
    return await servicioTuristicoRepository.getServicioTuristico();
  }
}