import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';

part 'emprendimiento_api_client.g.dart';

@RestApi()
abstract class EmprendimientoApiClient {
  factory EmprendimientoApiClient(Dio dio, {String baseUrl}) = _EmprendimientoApiClient;

  @GET("/admin/emprendimiento")
  Future<List<EmprendimientoResponse>> getEmprendimientos();

  @GET("/admin/emprendimiento/{idEmprendimiento}")
  Future<EmprendimientoResponse> getEmprendimientoById(@Path("idEmprendimiento") int idEmprendimiento);

  @POST("/admin/emprendimiento")
  @MultiPart()
  Future<EmprendimientoResponse> postEmprendimiento(
      @Part(name: "emprendimiento") String emprendimientoJson,
      @Part(name: "file") MultipartFile? file,
      );

  @PUT("/admin/emprendimiento/{idEmprendimiento}")
  @MultiPart()
  Future<EmprendimientoResponse> putEmprendimiento(
      @Path("idEmprendimiento") int idEmprendimiento,
      @Part(name: "emprendimiento") String emprendimientoJson,
      @Part(name: "file") MultipartFile? file,
      );

  @DELETE("/admin/emprendimiento/{idEmprendimiento}")
  Future<void> deleteEmprendimiento(@Path("idEmprendimiento") int idEmprendimiento);

  @GET("/admin/emprendimiento/buscar")
  Future<List<EmprendimientoResponse>> buscarEmprendimientosPorNombre(
      @Query("nombre") String nombre,
      );
}