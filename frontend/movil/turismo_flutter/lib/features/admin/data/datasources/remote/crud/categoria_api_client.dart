import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';

part "categoria_api_client.g.dart";

@RestApi()
abstract class CategoriaApiClient {
  factory CategoriaApiClient(Dio dio, {String baseUrl}) = _CategoriaApiClient;

  @GET("/admin/categoria")
  Future<List<CategoriaResponse>> getCategorias();

  @GET("/admin/categoria/{idCategoria}")
  Future<CategoriaResponse> getCategoriaById(@Path("idCategoria") int idCategoria);

  @POST("/admin/categoria")
  Future<CategoriaResponse> postCategoria(
      @Part(name: "categoria") String categoriaJson,
      @Part(name: "file") MultipartFile? file
      );

  @PUT("/admin/categoria/{idCategoria}")
  Future<CategoriaResponse> putCategoria(
      @Path("idCategoria") int idCategoria,
      @Part(name: "categoria") String categoriaJson,
      @Part(name: "file") MultipartFile? file
      );

  @DELETE("/admin/categoria/{idCategoria}")
  Future<void> deleteCategoria(@Path("idCategoria") int idCategoria);

  @GET("/admin/categoria/buscar")
  Future<List<CategoriaResponse>> buscarCategoriasPorNombre(
      @Query("nombre") String nombre,
      );
}