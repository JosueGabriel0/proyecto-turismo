import 'package:turismo_flutter/features/emprendedor/domain/repositories/servicio_turistico_emprendedor_repository.dart';

class DeleteServicioTuristicoEmprendedorUsecase {
  final ServicioTuristicoEmprendedorRepository repository;

  DeleteServicioTuristicoEmprendedorUsecase(this.repository);

  Future<void> call(int idServicio) {
    return repository.deleteServicioTuristico(idServicio);
  }
}
