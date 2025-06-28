import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/admin/data/models/chat_resumen_dto.dart';
import 'package:turismo_flutter/features/chat/data/models/mensaje_dto.dart';

part 'mensaje_api_client.g.dart';

@RestApi()
abstract class MensajeApiClient {
  factory MensajeApiClient(Dio dio, {String baseUrl}) = _MensajeApiClient;

  @GET("/admin/mensajes/historial")
  Future<List<MensajeDto>> obtenerHistorial(@Query("usuarioId") int usuarioId);

  @GET("/admin/mensajes/recientes")
  Future<List<ChatResumenDto>> obtenerChatsRecientes();
}