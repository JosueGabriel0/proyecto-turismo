import 'package:turismo_flutter/features/usuario/data/models/reserva_user_response.dart';
import 'package:turismo_flutter/features/usuario/domain/repositories/reserva_repository.dart';

class ObtenerReservasPorIdUsuariUsecase {
  final ReservaRepository repository;

  ObtenerReservasPorIdUsuariUsecase(this.repository);

  Future<List<ReservaUserResponse>> call(int id) {
    return repository.obtenerReservasPorIdUsuario(id);
  }
}
