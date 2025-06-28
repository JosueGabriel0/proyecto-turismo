import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/mensaje_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/chat_resumen_dto.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/mensaje_admin_repository.dart';
import 'package:turismo_flutter/features/chat/data/models/mensaje_dto.dart';

class MensajeAdminRepositoryImpl implements MensajeAdminRepository {
  final MensajeApiClient apiClient;

  MensajeAdminRepositoryImpl(this.apiClient);

  @override
  Future<List<MensajeDto>> obtenerHistorial(int usuarioId) {
    return apiClient.obtenerHistorial(usuarioId);
  }

  @override
  Future<List<ChatResumenDto>> obtenerChatsRecientes() {
    return apiClient.obtenerChatsRecientes();
  }
}