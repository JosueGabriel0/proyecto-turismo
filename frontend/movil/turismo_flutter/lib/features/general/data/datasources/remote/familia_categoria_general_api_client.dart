import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_post.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_response.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_response.dart';
import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';
import 'package:turismo_flutter/features/general/data/models/familia_categoria_general_dto_response.dart';

part 'familia_categoria_general_api_client.g.dart';

@RestApi()
abstract class FamiliaCategoriaGeneralApiClient{
  factory FamiliaCategoriaGeneralApiClient(Dio dio, {String baseUrl}) = _FamiliaCategoriaGeneralApiClient;

  @GET("/general/familiaCategoria")
  Future<List<FamiliaCategoriaGeneralDtoResponse>> listarRelaciones();

  @GET("/general/familiaCategoria/familia/{idFamilia}")
  Future<List<FamiliaCategoriaGeneralDtoResponse>> obtenerFamiliaCategoriaPorIdFamilia(
      @Path("idFamilia") int idFamilia
      );

  @GET("/general/familiaCategoria/categoria/{idCategoria}")
  Future<List<FamiliaCategoriaGeneralDtoResponse>> obtenerFamiliaCategoriaPorIdCategoria(
      @Path("idCategoria") int idCategoria
      );

  @GET("/general/familiaCategoria/{idFamiliaCategoria}/emprendimientos")
  Future<List<EmprendimientoGeneralResponse>> getEmprendimientosPorFamiliaCategoria(
      @Path("idFamiliaCategoria") int idFamiliaCategoria,
      @Query("nombre") String? nombre,
      );
}