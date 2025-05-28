import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_completo_response.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_response.dart';

part 'reserva_emprendedor_api_client.g.dart';

@RestApi()
abstract class ReservaEmprendedorApiClient {
  factory ReservaEmprendedorApiClient(Dio dio, {String baseUrl}) = _ReservaEmprendedorApiClient;

  @POST("/emprendedor/reserva")
  Future<ReservaEmprendedorResponse> crearReserva(@Body() ReservaEmprendedorDto reserva);

  @PUT("/emprendedor/reserva/{idReserva}/estado")
  Future<ReservaEmprendedorResponse> actualizarReservaPorId(
      @Path("idReserva") int idReserva,
      @Query("nuevoEstado") String nuevoEstado,
      );



  @GET("/emprendedor/reserva/idEmprendimiento/{idEmprendimiento}")
  Future<List<ReservaEmprendedorCompletoResponse>> obtenerReservasPorIdEmprendimiento(
      @Path("idEmprendimiento") int idEmprendimiento,
      );

  @GET("/emprendedor/reserva/{idReserva}")
  Future<ReservaEmprendedorCompletoResponse> obtenerReservaPorId(
      @Path("idReserva") int idReserva
      );
}