import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_completo_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/reserva_emprendedor_repository.dart';

class ObtenerReservaPorIdUseCase {
  final ReservaEmprendedorRepository repository;

  ObtenerReservaPorIdUseCase(this.repository);

  Future<ReservaEmprendedorCompletoResponse> call(int idReserva) {
    return repository.obtenerReservaPorId(idReserva);
  }
}