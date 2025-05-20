import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/emprendimiento_repository.dart';

class BuscarEmprendimientosPorNombreUseCase {
  final EmprendimientoRepository repository;

  BuscarEmprendimientosPorNombreUseCase(this.repository);

  Future<List<EmprendimientoResponse>> call(String nombre) {
    return repository.buscarEmprendimientosPorNombre(nombre);
  }
}