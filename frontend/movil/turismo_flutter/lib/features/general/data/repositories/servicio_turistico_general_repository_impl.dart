import 'package:turismo_flutter/features/general/data/datasources/remote/servicio_turistico_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/models/servicio_turistico_response_general.dart';
import 'package:turismo_flutter/features/general/domain/repositories/servicio_turistico_general_repository.dart';

class ServicioTuristicoGeneralRepositoryImpl implements ServicioTuristicoGeneralRepository {
  final ServicioTuristicoGeneralApiClient apiClient;

  ServicioTuristicoGeneralRepositoryImpl(this.apiClient);

  @override
  Future<List<ServicioTuristicoResponseGeneral>> getServiciosPorEmprendimiento(int idEmprendimiento) {
    return apiClient.getServicioTuristicoByIdEmprendimiento(idEmprendimiento);
  }
}
