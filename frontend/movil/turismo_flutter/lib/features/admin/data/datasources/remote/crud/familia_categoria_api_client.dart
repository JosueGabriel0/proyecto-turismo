import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_post.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_response.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_response.dart';

part 'familia_categoria_api_client.g.dart';

@RestApi()
abstract class FamiliaCategoriaApiClient{
  factory FamiliaCategoriaApiClient(Dio dio, {String baseUrl}) = _FamiliaCategoriaApiClient;
  @POST("/admin/familiaCategoria")
  Future<FamiliaCategoriaResponse> asociarFamiliaConCategoria(
      @Body() FamiliaCategoriaDtoPost request,
      );

  @GET("/admin/familiaCategoria")
  Future<List<FamiliaCategoriaDtoResponse>> listarRelaciones();

  @GET("/admin/familiaCategoria/familia/{idFamilia}")
  Future<List<FamiliaCategoriaDtoResponse>> obtenerFamiliaCategoriaPorIdFamilia(
      @Path("idFamilia") int idFamilia
      );

  @GET("/admin/familiaCategoria/categoria/{idCategoria}")
  Future<List<FamiliaCategoriaDtoResponse>> obtenerFamiliaCategoriaPorIdCategoria(
      @Path("idCategoria") int idCategoria
      );
  
  @DELETE("/admin/familiaCategoria/{idFamiliaCategoria}")
  Future<void> eliminarRelacion(
    @Path("idFamiliaCategoria") int idFamiliaCategoria
  );
}