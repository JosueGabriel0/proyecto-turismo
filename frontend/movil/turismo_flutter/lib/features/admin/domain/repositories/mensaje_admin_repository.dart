import 'package:turismo_flutter/features/admin/data/models/chat_resumen_dto.dart';
import 'package:turismo_flutter/features/chat/data/models/mensaje_dto.dart';

abstract class MensajeAdminRepository {
  Future<List<MensajeDto>> obtenerHistorial(int usuarioId);
  Future<List<ChatResumenDto>> obtenerChatsRecientes();
}
