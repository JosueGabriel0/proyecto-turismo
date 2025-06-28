import 'package:turismo_flutter/features/general/data/models/ubicacion_dto.dart';

abstract class UbicacionRepository {
  Future<List<UbicacionDto>> obtenerUbicaciones();
}
