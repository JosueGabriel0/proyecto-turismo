import 'package:turismo_flutter/features/emprendedor/data/datasources/remote/reserva_emprendedor_api_client.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_completo_response.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/reserva_emprendedor_repository.dart';

class ReservaEmprendedorRepositoryImpl implements ReservaEmprendedorRepository {
  final ReservaEmprendedorApiClient apiClient;

  ReservaEmprendedorRepositoryImpl(this.apiClient);

  @override
  Future<ReservaEmprendedorResponse> crearReserva(ReservaEmprendedorDto reserva) {
    return apiClient.crearReserva(reserva);
  }

  @override
  Future<ReservaEmprendedorResponse> actualizarReservaPorId(int idReserva, String nuevoEstado) {
    return apiClient.actualizarReservaPorId(idReserva, nuevoEstado);
  }

  @override
  Future<List<ReservaEmprendedorCompletoResponse>> obtenerReservasPorIdEmprendimiento(int idEmprendimiento) {
    return apiClient.obtenerReservasPorIdEmprendimiento(idEmprendimiento);
  }

  @override
  Future<ReservaEmprendedorCompletoResponse> obtenerReservaPorId(int idReserva) {
    return apiClient.obtenerReservaPorId(idReserva);
  }
}