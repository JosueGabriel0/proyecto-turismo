import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';

class BuscarLugaresPorNombreUsecase {
  final LugarRepository repository;

  BuscarLugaresPorNombreUsecase(this.repository);

  Future<List<LugarResponse>> call(String nombre) {
    return repository.buscarLugaresPorNombre(nombre);
  }
}