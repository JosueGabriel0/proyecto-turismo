import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/servicio_turistico_emprendedor_repository.dart';

class BuscarServiciosTuristicosPorNombreEmprendedorUsecase {
  final ServicioTuristicoEmprendedorRepository repository;

  BuscarServiciosTuristicosPorNombreEmprendedorUsecase(this.repository);

  Future<List<ServicioTuristicoEmprendedorResponse>> call(String nombre) {
    return repository.buscarServiciosTuristicosPorNombre(nombre);
  }
}