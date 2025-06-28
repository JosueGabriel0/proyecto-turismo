import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/usuario/data/models/chat_resumen_dto.dart';
import 'package:turismo_flutter/features/usuario/data/models/mensaje_dto.dart';

part 'mensaje_usuario_api_client.g.dart';

@RestApi()
abstract class MensajeUsuarioApiClient {
  factory MensajeUsuarioApiClient(Dio dio, {String baseUrl}) = _MensajeUsuarioApiClient;

  @GET("/usuario/mensajes/historial")
  Future<List<MensajeDto>> obtenerHistorial(@Query("usuarioId") int usuarioId);

  @GET("/usuario/mensajes/recientes")
  Future<List<ChatResumenDto>> obtenerChatsRecientes();
}