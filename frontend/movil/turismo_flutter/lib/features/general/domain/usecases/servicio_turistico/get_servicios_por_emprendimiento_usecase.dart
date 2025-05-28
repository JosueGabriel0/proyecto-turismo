import 'package:turismo_flutter/features/general/data/models/servicio_turistico_response_general.dart';
import 'package:turismo_flutter/features/general/domain/repositories/servicio_turistico_general_repository.dart';

class GetServiciosPorEmprendimientoUseCase {
  final ServicioTuristicoGeneralRepository repository;

  GetServiciosPorEmprendimientoUseCase(this.repository);

  Future<List<ServicioTuristicoResponseGeneral>> call(int idEmprendimiento) {
    return repository.getServiciosPorEmprendimiento(idEmprendimiento);
  }
}