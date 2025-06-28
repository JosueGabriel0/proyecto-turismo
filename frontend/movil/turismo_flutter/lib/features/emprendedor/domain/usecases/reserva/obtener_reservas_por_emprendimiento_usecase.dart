import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_completo_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/reserva_emprendedor_repository.dart';

class ObtenerReservasPorEmprendimientoUseCase {
  final ReservaEmprendedorRepository repository;

  ObtenerReservasPorEmprendimientoUseCase(this.repository);

  Future<List<ReservaEmprendedorCompletoResponse>> call(int idEmprendimiento) {
    return repository.obtenerReservasPorIdEmprendimiento(idEmprendimiento);
  }
}