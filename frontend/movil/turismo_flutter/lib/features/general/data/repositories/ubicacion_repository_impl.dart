import 'package:turismo_flutter/features/general/data/datasources/remote/ubicacion_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/models/ubicacion_dto.dart';
import 'package:turismo_flutter/features/general/domain/repositories/ubicacion_repository.dart';

class UbicacionRepositoryImpl implements UbicacionRepository {
  final UbicacionGeneralApiClient apiClient;

  UbicacionRepositoryImpl(this.apiClient);

  @override
  Future<List<UbicacionDto>> obtenerUbicaciones() async {
    try {
      return await apiClient.obtenerUbicaciones();
    } catch (e) {
      // Manejar error, log o lanzar una excepción personalizada si deseas
      rethrow;
    }
  }
}