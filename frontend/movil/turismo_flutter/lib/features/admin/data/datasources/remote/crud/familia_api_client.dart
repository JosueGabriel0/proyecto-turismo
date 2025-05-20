import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';

part 'familia_api_client.g.dart';

@RestApi()
abstract class FamiliaApiClient {
  factory FamiliaApiClient(Dio dio, {String baseUrl}) = _FamiliaApiClient;

  @GET("/admin/familia")
  Future<List<FamiliaResponse>> getFamilias();

  @GET("/admin/familia/{idFamilia}")
  Future<FamiliaResponse> getFamiliaById(@Path("idFamilia") int idFamilia);

  @POST("/admin/familia")
  @MultiPart()
  Future<FamiliaResponse> postFamilia(
      @Part(name:  "familia") String familiaJson,
      @Part(name: "file") MultipartFile? file,
      );

  @PUT("/admin/familia/{idFamilia}")
  @MultiPart()
  Future<FamiliaResponse> putFamilia(
      @Path("idFamilia") int idFamilia,
      @Part(name: "familia") String familiaJson,
      @Part(name: "file") MultipartFile? file,
      );

  @DELETE("/admin/familia/{idFamilia}")
  Future<void> deleteFamilia(@Path("idFamilia") int idFamilia);

  @GET("/admin/familia/buscar")
  Future<List<FamiliaResponse>> buscarFamiliasPorNombre(
      @Query("nombre") String nombre,
      );
}