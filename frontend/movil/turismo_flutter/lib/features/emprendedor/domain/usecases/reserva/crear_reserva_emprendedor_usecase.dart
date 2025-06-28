import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/reserva_emprendedor_repository.dart';

class CrearReservaEmprendedorUsecase {
  final ReservaEmprendedorRepository repository;

  CrearReservaEmprendedorUsecase(this.repository);

  Future<ReservaEmprendedorResponse> call(ReservaEmprendedorDto reserva) {
    return repository.crearReserva(reserva);
  }
}
