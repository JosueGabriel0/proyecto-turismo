import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/general/data/models/familia_general_response.dart';
import 'package:turismo_flutter/features/general/data/models/lugar_general_response.dart';

part 'lugar_general_api_client.g.dart';

@RestApi()
abstract class LugarGeneralApiClient {
  factory LugarGeneralApiClient(Dio dio, {String baseUrl}) = _LugarGeneralApiClient;

  // Obtener todos los lugares
  @GET("/general/lugar")
  Future<List<LugarGeneralResponse>> getLugares();

  @GET("/general/lugar/buscar")
  Future<List<LugarGeneralResponse>> buscarLugaresPorNombre(
      @Query("nombre") String nombre,
      );

  @GET("/general/lugar/{idLugar}/familias")
  Future<List<FamiliaGeneralResponse>> getFamiliasPorLugar(
      @Path("idLugar") int idLugar,
      @Query("nombre") String? nombre,
      );

}