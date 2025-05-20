import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_repository.dart';

class BuscarFamiliasPorNombreUsecase {
  final FamiliaRepository repository;

  BuscarFamiliasPorNombreUsecase(this.repository);

  Future<List<FamiliaResponse>> call(String nombre) {
    return repository.buscarFamiliasPorNombre(nombre);
  }
}