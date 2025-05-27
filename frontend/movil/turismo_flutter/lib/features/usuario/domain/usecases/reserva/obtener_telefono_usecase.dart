import 'package:turismo_flutter/features/usuario/domain/repositories/reserva_repository.dart';

class ObtenerTelefonoUseCase {
  final ReservaRepository repository;

  ObtenerTelefonoUseCase(this.repository);

  Future<String> call(int idEmprendimiento) {
    return repository.obtenerTelefonoPorIdEmprendimiento(idEmprendimiento);
  }
}
