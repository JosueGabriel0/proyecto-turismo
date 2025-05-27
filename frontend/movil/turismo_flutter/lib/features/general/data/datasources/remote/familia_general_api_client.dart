import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/general/data/models/familia_general_response.dart';

part 'familia_general_api_client.g.dart';

@RestApi()
abstract class FamiliaGeneralApiClient {
  factory FamiliaGeneralApiClient(Dio dio, {String baseUrl}) = _FamiliaGeneralApiClient;

  @GET("/general/familia")
  Future<List<FamiliaGeneralResponse>> getFamilias();

  @GET("/general/familia/{idFamilia}")
  Future<FamiliaGeneralResponse> getFamiliaById(@Path("idFamilia") int idFamilia);

  @GET("/general/familia/buscar")
  Future<List<FamiliaGeneralResponse>> buscarFamiliasPorNombre(
      @Query("nombre") String nombre,
      );
}