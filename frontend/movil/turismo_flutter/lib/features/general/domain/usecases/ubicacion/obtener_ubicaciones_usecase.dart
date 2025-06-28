import 'package:turismo_flutter/features/general/data/models/ubicacion_dto.dart';
import 'package:turismo_flutter/features/general/domain/repositories/ubicacion_repository.dart';

class ObtenerUbicacionesUseCase {
  final UbicacionRepository repository;

  ObtenerUbicacionesUseCase(this.repository);

  Future<List<UbicacionDto>> call() async {
    return await repository.obtenerUbicaciones();
  }
}