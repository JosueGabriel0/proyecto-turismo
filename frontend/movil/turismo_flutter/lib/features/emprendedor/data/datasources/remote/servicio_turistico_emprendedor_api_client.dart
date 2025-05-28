import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_response.dart';

part 'servicio_turistico_emprendedor_api_client.g.dart';

@RestApi()
abstract class ServicioTuristicoEmprendedorApiClient {
  factory ServicioTuristicoEmprendedorApiClient(Dio dio, {String baseUrl}) = _ServicioTuristicoEmprendedorApiClient;

  @GET("/emprendedor/servicioTuristico/emprendimiento/{idEmprendimiento}")
  Future<List<ServicioTuristicoEmprendedorResponse>> getServicioTuristicosPorIdEmprendimiento(
      @Path("idEmprendimiento") int idEmprendimiento
      );

  @GET("/emprendedor/servicioTuristico/{idServicio}")
  Future<ServicioTuristicoEmprendedorResponse> getServicioTuristicoById(@Path("idServicio") int idServicio);

  @POST("/emprendedor/servicioTuristico")
  @MultiPart()
  Future<ServicioTuristicoEmprendedorResponse> postServicioTuristico(
      @Part(name: "servicioTuristico") String servicioTuristicoJson,
      @Part(name: "file") MultipartFile? file,
      );

  @PUT("/emprendedor/servicioTuristico/{idServicio}")
  @MultiPart()
  Future<ServicioTuristicoEmprendedorResponse> putServicioTuristico(
      @Path("idServicio") int idServicio,
      @Part(name: "servicioTuristico") String servicioTuristicoJson,
      @Part(name: "file") MultipartFile? file,
      );

  @DELETE("/emprendedor/servicioTuristico/{idServicio}")
  Future<void> deleteServicioTuristico(@Path("idServicio") int idServicio);

  @GET("/emprendedor/servicioTuristico/buscar")
  Future<List<ServicioTuristicoEmprendedorResponse>> buscarServiciosTuristicosPorNombre(
      @Query("nombre") String nombre,
      );
}