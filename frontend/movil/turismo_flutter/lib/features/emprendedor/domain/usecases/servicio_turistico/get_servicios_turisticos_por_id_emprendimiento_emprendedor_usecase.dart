import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/servicio_turistico_emprendedor_repository.dart';

class GetServiciosTuristicosPorIdEmprendimientoEmprendedorUsecase {
  final ServicioTuristicoEmprendedorRepository repository;

  GetServiciosTuristicosPorIdEmprendimientoEmprendedorUsecase(this.repository);

  Future<List<ServicioTuristicoEmprendedorResponse>> call(int idEmprendimiento) {
    return repository.getServicioTuristicosPorIdEmprendimiento(idEmprendimiento);
  }
}
