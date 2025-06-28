import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/general/data/models/ubicacion_dto.dart';

part "ubicacion_general_api_client.g.dart";

@RestApi()
abstract class UbicacionGeneralApiClient {
  factory UbicacionGeneralApiClient(Dio dio, {String baseUrl}) = _UbicacionGeneralApiClient;

  @GET("/general/ubicaciones")
  Future<List<UbicacionDto>> obtenerUbicaciones();
}