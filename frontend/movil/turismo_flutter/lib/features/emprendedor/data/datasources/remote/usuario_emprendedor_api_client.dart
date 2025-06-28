import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/usuario_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/usuario_id_mensaje_emprendedor_dto_response.dart';

part 'usuario_emprendedor_api_client.g.dart';

@RestApi()
abstract class UsuarioEmprendedorApiClient {
  factory UsuarioEmprendedorApiClient(Dio dio, {String baseUrl}) = _UsuarioEmprendedorApiClient;

  // Obtener un usuario completo por ID
  @GET("/emprendedor/usuarioCompleto/{idUsuario}")
  Future<UsuarioEmprendedorResponse> getUsuarioCompletoById(
      @Path("idUsuario") int idUsuario);

  // Actualizar un usuario con foto (multipart)
  @PUT("/emprendedor/usuarioCompleto/{idUsuario}")
  @MultiPart()
  Future<UsuarioEmprendedorResponse> putUsuarioCompleto(
      @Path("idUsuario") int idUsuario,
      @Part(name: "usuario") String usuarioJson,
      @Part(name: "file") MultipartFile? file);

  @GET("/emprendedor/usuarioCompleto/buscarIdPorUsername/{userName}")
  Future<UsuarioIdMensajeEmprendedorDtoResponse> buscarIdPorUsername(
      @Path("userName") String userName
      );
}