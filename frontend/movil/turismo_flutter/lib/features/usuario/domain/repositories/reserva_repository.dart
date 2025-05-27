import 'package:turismo_flutter/features/admin/data/models/reserva_response.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_dto.dart';

abstract class ReservaRepository {
  Future<ReservaResponse> crearReserva(ReservaDto reserva);
  Future<String> obtenerTelefonoPorIdEmprendimiento(int idEmprendimiento);
}