import 'package:turismo_flutter/features/usuario/data/models/reserva_dto.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_response.dart';
import 'package:turismo_flutter/features/usuario/domain/repositories/reserva_repository.dart';

class CrearReservaUseCase {
  final ReservaRepository repository;

  CrearReservaUseCase(this.repository);

  Future<ReservaResponse> call(ReservaDto reserva) {
    return repository.crearReserva(reserva);
  }
}
