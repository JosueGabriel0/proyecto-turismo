import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/servicio_turistico_emprendedor_repository.dart';

class GetServicioTuristicoByIdEmprendedorUsecase {
  final ServicioTuristicoEmprendedorRepository repository;

  GetServicioTuristicoByIdEmprendedorUsecase(this.repository);

  Future<ServicioTuristicoEmprendedorResponse> call(int idServicio) {
    return repository.getServicioTuristicoById(idServicio);
  }
}
