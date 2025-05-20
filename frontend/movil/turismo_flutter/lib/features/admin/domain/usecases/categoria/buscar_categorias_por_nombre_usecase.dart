import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/categoria_repository.dart';

class BuscarCategoriasPorNombreUsecase {
  final CategoriaRepository repository;

  BuscarCategoriasPorNombreUsecase(this.repository);

  Future<List<CategoriaResponse>> call(String nombre) {
    return repository.buscarCategoriasPorNombre(nombre);
  }
}