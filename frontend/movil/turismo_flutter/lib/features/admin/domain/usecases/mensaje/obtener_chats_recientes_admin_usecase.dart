import 'package:turismo_flutter/features/admin/data/models/chat_resumen_dto.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/mensaje_admin_repository.dart';

class ObtenerChatsRecientesAdminUsecase {
  final MensajeAdminRepository repository;

  ObtenerChatsRecientesAdminUsecase(this.repository);

  Future<List<ChatResumenDto>> call() {
    return repository.obtenerChatsRecientes();
  }
}
