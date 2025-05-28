import 'package:turismo_flutter/features/usuario/data/models/reserva_dto.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_response.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_user_response.dart';

abstract class ReservaRepository {
  Future<ReservaResponse> crearReserva(ReservaDto reserva);
  Future<String> obtenerTelefonoPorIdEmprendimiento(int idEmprendimiento);
  Future<List<ReservaUserResponse>> obtenerReservasPorIdUsuario(int id);
  Future<ReservaUserResponse> obtenerReservaPorId(int idReserva);
}