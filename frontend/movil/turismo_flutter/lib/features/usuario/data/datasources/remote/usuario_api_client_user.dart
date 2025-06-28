import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_id_mensaje_usuario_dto_response.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';

part 'usuario_api_client_user.g.dart';

@RestApi()
abstract class UsuarioApiClientUser {
  factory UsuarioApiClientUser(Dio dio, {String baseUrl}) = _UsuarioApiClientUser;

  // Obtener un usuario completo por ID
  @GET("/usuario/usuarioCompleto/{idUsuario}")
  Future<UsuarioUserResponse> getUsuarioCompletoById(
      @Path("idUsuario") int idUsuario);

  // Actualizar un usuario con foto (multipart)
  @PUT("/usuario/usuarioCompleto/{idUsuario}")
  @MultiPart()
  Future<UsuarioUserResponse> putUsuarioCompletoUser(
      @Path("idUsuario") int idUsuario,
      @Part(name: "usuario") String usuarioJson,
      @Part(name: "file") MultipartFile? file);

  @GET("/usuario/usuarioCompleto/buscarIdPorUsername/{userName}")
  Future<UsuarioIdMensajeUsuarioDtoResponse> buscarIdPorUsername(
      @Path("userName") String userName
      );
}