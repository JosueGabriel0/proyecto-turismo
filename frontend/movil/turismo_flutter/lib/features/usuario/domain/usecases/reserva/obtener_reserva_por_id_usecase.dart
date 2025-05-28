import 'package:turismo_flutter/features/usuario/data/models/reserva_user_response.dart';
import 'package:turismo_flutter/features/usuario/domain/repositories/reserva_repository.dart';

class ObtenerReservaPorIdUsecase {
  final ReservaRepository repository;

  ObtenerReservaPorIdUsecase(this.repository);

  Future<ReservaUserResponse> call(int idReserva) {
    return repository.obtenerReservaPorId(idReserva);
  }
}
