import 'package:turismo_flutter/features/admin/data/models/rol_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/rol_repository.dart';

class BuscarRolesPorNombreUsecase {
  final RolRepository repository;

  BuscarRolesPorNombreUsecase(this.repository);

  Future<List<RolResponse>> call(String nombre) {
    return repository.buscarRolesPorNombre(nombre);
  }
}