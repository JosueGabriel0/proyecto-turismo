import 'package:turismo_flutter/features/usuario/data/datasources/remote/reserva_api_client.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_dto.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_response.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_user_response.dart';
import 'package:turismo_flutter/features/usuario/domain/repositories/reserva_repository.dart';

class ReservaRepositoryImpl implements ReservaRepository {
  final ReservaApiClient apiClient;

  ReservaRepositoryImpl(this.apiClient);

  @override
  Future<ReservaResponse> crearReserva(ReservaDto reserva) {
    return apiClient.crearReserva(reserva);
  }

  @override
  Future<String> obtenerTelefonoPorIdEmprendimiento(int idEmprendimiento) {
    return apiClient.obtenerTelefonoPorIdEmprendimiento(idEmprendimiento);
  }

  @override
  Future<List<ReservaUserResponse>> obtenerReservasPorIdUsuario(int id){
    return apiClient.obtenerReservasPorIdUsuario(id);
  }

  @override
  Future<ReservaUserResponse> obtenerReservaPorId(int idReserva){
    return apiClient.obtenerReservaPorId(idReserva);
  }
}