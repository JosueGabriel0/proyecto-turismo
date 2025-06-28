import 'package:turismo_flutter/features/admin/domain/repositories/mensaje_admin_repository.dart';
import 'package:turismo_flutter/features/chat/data/models/mensaje_dto.dart';

class ObtenerHistorialAdminUsecase {
  final MensajeAdminRepository repository;

  ObtenerHistorialAdminUsecase(this.repository);

  Future<List<MensajeDto>> call(int usuarioId) {
    return repository.obtenerHistorial(usuarioId);
  }
}
