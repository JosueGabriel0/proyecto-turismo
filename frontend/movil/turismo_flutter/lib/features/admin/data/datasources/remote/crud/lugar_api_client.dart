import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';

part 'lugar_api_client.g.dart';

@RestApi()
abstract class LugarApiClient {
  factory LugarApiClient(Dio dio, {String baseUrl}) = _LugarApiClient;

  // Obtener todos los lugares
  @GET("/admin/lugar")
  Future<List<LugarResponse>> getLugares();

  // Obtener un lugar por ID
  @GET("/admin/lugar/{idLugar}")
  Future<LugarResponse> getLugarById(@Path("idLugar") int idLugar);

  // Crear un nuevo lugar con imagen
  @POST("/admin/lugar")
  @MultiPart()
  Future<LugarResponse> postLugar(
      @Part(name: "lugar") String lugarJson,
      @Part(name: "file") MultipartFile? file,
      );

  // Actualizar un lugar con imagen
  @PUT("/admin/lugar/{idLugar}")
  @MultiPart()
  Future<LugarResponse> putLugar(
      @Path("idLugar") int idLugar,
      @Part(name: "lugar") String lugarJson,
      @Part(name: "file") MultipartFile? file,
      );

  // Eliminar un lugar
  @DELETE("/admin/lugar/{idLugar}")
  Future<void> deleteLugar(@Path("idLugar") int idLugar);

  @GET("/admin/lugar/buscar")
  Future<List<LugarResponse>> buscarLugaresPorNombre(
      @Query("nombre") String nombre,
      );
}