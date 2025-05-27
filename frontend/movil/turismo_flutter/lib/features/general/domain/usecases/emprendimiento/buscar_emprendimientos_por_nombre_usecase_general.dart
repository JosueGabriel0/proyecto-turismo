import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/emprendimiento_repository.dart';
import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/emprendimiento_general_repository.dart';

class BuscarEmprendimientosPorNombreUseCaseGeneral {
  final EmprendimientoGeneralRepository repository;

  BuscarEmprendimientosPorNombreUseCaseGeneral(this.repository);

  Future<List<EmprendimientoGeneralResponse>> call(String nombre) {
    return repository.buscarEmprendimientosPorNombreGeneral(nombre);
  }
}