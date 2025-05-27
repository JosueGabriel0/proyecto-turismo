import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_response.dart';

part 'servicio_turistico_api_client.g.dart';

@RestApi()
abstract class ServicioTuristicoApiClient {
  factory ServicioTuristicoApiClient(Dio dio, {String baseUrl}) = _ServicioTuristicoApiClient;

  @GET("/admin/servicioTuristico")
  Future<List<ServicioTuristicoResponse>> getServicioTuristico();

  @GET("/admin/servicioTuristico/{idServicio}")
  Future<ServicioTuristicoResponse> getServicioTuristicoById(@Path("idServicio") int idServicio);

  @POST("/admin/servicioTuristico")
  @MultiPart()
  Future<ServicioTuristicoResponse> postServicioTuristico(
      @Part(name: "servicioTuristico") String servicioTuristicoJson,
      @Part(name: "file") MultipartFile? file,
      );

  @PUT("/admin/servicioTuristico/{idServicio}")
  @MultiPart()
  Future<ServicioTuristicoResponse> putServicioTuristico(
      @Path("idServicio") int idServicio,
      @Part(name: "servicioTuristico") String servicioTuristicoJson,
      @Part(name: "file") MultipartFile? file,
      );

  @DELETE("/admin/servicioTuristico/{idServicio}")
  Future<void> deleteServicioTuristico(@Path("idServicio") int idServicio);

  @GET("/admin/servicioTuristico/buscar")
  Future<List<ServicioTuristicoResponse>> buscarLugaresPorNombre(
      @Query("nombre") String nombre,
      );
}