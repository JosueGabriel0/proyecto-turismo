import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_completo_response.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_response.dart';

abstract class ReservaEmprendedorRepository {
  Future<ReservaEmprendedorResponse> crearReserva(ReservaEmprendedorDto reserva);
  Future<ReservaEmprendedorResponse> actualizarReservaPorId(int idReserva, String nuevoEstado);
  Future<List<ReservaEmprendedorCompletoResponse>> obtenerReservasPorIdEmprendimiento(int idEmprendimiento);
  Future<ReservaEmprendedorCompletoResponse> obtenerReservaPorId(int idReserva);
}