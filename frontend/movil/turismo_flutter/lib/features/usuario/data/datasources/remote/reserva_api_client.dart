import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:turismo_flutter/features/admin/data/models/reserva_response.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_dto.dart';

part 'reserva_api_client.g.dart';

@RestApi()
abstract class ReservaApiClient {
  factory ReservaApiClient(Dio dio, {String baseUrl}) = _ReservaApiClient;

  @POST("/usuario/reserva")
  Future<ReservaResponse> crearReserva(@Body() ReservaDto reserva);

  @GET("/usuario/reserva/telefono/{idEmprendimiento}")
  Future<String> obtenerTelefonoPorIdEmprendimiento(
      @Path("idEmprendimiento") int idEmprendimiento
      );
}