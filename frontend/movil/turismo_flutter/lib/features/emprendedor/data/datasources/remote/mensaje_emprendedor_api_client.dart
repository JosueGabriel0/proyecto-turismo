import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/chat_resumen_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/mensaje_dto.dart';

part 'mensaje_emprendedor_api_client.g.dart';

@RestApi()
abstract class MensajeEmprendedorApiClient {
  factory MensajeEmprendedorApiClient(Dio dio, {String baseUrl}) = _MensajeEmprendedorApiClient;

  @GET("/emprendedor/mensajes/historial")
  Future<List<MensajeDto>> obtenerHistorial(@Query("usuarioId") int usuarioId);

  @GET("/emprendedor/mensajes/recientes")
  Future<List<ChatResumenDto>> obtenerChatsRecientes();
}