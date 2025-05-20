import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_response.dart';

part 'rol_api_client.g.dart';

@RestApi()
abstract class RolApiClient {
  factory RolApiClient(Dio dio, {String baseUrl}) = _RolApiClient;

  @GET("/admin/rol")  // Obtener todos los roles
  Future<List<RolResponse>> getRoles();

  @GET("/admin/rol/{idRol}")  // Obtener un rol por ID
  Future<RolResponse> getRolById(@Path("idRol") int idRol);

  @POST("/admin/rol")  // Crear un nuevo rol
  Future<RolResponse> createRol(@Body() RolDto rolDto);

  @PUT("/admin/rol/{idRol}")  // Actualizar un rol
  Future<RolResponse> updateRol(
      @Path("idRol") int idRol,
      @Body() RolDto rolDto,
      );

  @DELETE("/admin/rol/{idRol}")  // Eliminar un rol
  Future<void> deleteRol(@Path("idRol") int idRol);

  @GET("/admin/rol/buscar")
  Future<List<RolResponse>> buscarRolesPorNombre(
      @Query("nombre") String nombre,
      );
}