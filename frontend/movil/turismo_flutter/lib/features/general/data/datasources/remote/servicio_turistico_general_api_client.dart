import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/general/data/models/servicio_turistico_response_general.dart';

part "servicio_turistico_general_api_client.g.dart";

@RestApi()
abstract class ServicioTuristicoGeneralApiClient {
  factory ServicioTuristicoGeneralApiClient(Dio dio, {String baseUrl}) = _ServicioTuristicoGeneralApiClient;

  @GET("/general/servicioTuristico/emprendimiento/{idEmprendimiento}")
  Future<List<ServicioTuristicoResponseGeneral>> getServicioTuristicoByIdEmprendimiento(
      @Path("idEmprendimiento") int idEmprendimiento
      );
}