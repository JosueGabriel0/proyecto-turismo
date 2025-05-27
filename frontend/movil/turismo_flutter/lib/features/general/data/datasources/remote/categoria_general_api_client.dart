import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/general/data/models/categoria_general_response.dart';

part "categoria_general_api_client.g.dart";

@RestApi()
abstract class CategoriaGeneralApiClient {
  factory CategoriaGeneralApiClient(Dio dio, {String baseUrl}) = _CategoriaGeneralApiClient;

  @GET("/general/categoria")
  Future<List<CategoriaGeneralResponse>> getCategorias();

  @GET("/general/categoria/{idCategoria}")
  Future<CategoriaGeneralResponse> getCategoriaById(@Path("idCategoria") int idCategoria);

  @GET("/general/categoria/buscar")
  Future<List<CategoriaGeneralResponse>> buscarCategoriasPorNombre(
      @Query("nombre") String nombre,
      );
}