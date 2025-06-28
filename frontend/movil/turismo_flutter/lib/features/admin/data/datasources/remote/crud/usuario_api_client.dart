import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_id_mensaje_dto_response.dart';

part 'usuario_api_client.g.dart';

@RestApi()
abstract class UsuarioApiClient {
  factory UsuarioApiClient(Dio dio, {String baseUrl}) = _UsuarioApiClient;

  // Obtener todos los usuarios completos
  @GET("/admin/usuarioCompleto")
  Future<List<UsuarioCompletoResponse>> getUsuariosCompleto();

  // Obtener un usuario completo por ID
  @GET("/admin/usuarioCompleto/{idUsuario}")
  Future<UsuarioCompletoResponse> getUsuarioCompletoById(
      @Path("idUsuario") int idUsuario);

  // Crear un nuevo usuario con foto (multipart)
  @POST("/admin/usuarioCompleto")
  @MultiPart()
  Future<UsuarioCompletoResponse> postUsuarioCompleto(
      @Part(name: "usuario") String usuarioJson,
      @Part(name: "file") MultipartFile? file,
      );

  // Actualizar un usuario con foto (multipart)
  @PUT("/admin/usuarioCompleto/{idUsuario}")
  @MultiPart()
  Future<UsuarioCompletoResponse> putUsuarioCompleto(
      @Path("idUsuario") int idUsuario,
      @Part(name: "usuario") String usuarioJson,
      @Part(name: "file") MultipartFile? file);

  // Eliminar un usuario
  @DELETE("/admin/usuarioCompleto/{idUsuario}")
  Future<void> deleteUsuarioCompleto(@Path("idUsuario") int idUsuario);

  @GET("/admin/usuarioCompleto/buscar")
  Future<List<UsuarioCompletoResponse>> buscarUsuariosPorNombre(
      @Query("username") String username,
      );

  @GET("/admin/usuarioCompleto/buscarIdPorUsername/{userName}")
  Future<UsuarioIdMensajeDtoResponse> buscarIdPorUsername(
      @Path("userName") String userName
      );
}