import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/reserva_emprendedor_repository.dart';

class ActualizarReservaEmprendedorUsecase {
  final ReservaEmprendedorRepository repository;

  ActualizarReservaEmprendedorUsecase(this.repository);

  Future<ReservaEmprendedorResponse> call(int idReserva, String nuevoEstado) {
    return repository.actualizarReservaPorId(idReserva, nuevoEstado);
  }
}