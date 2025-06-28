import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart'; // <== ESTE ES EL IMPORT FALTANTE
import 'package:turismo_flutter/features/usuario/data/datasources/remote/usuario_api_client_user.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_dto_user.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_id_mensaje_usuario_dto_response.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';
import 'package:turismo_flutter/features/usuario/domain/repositories/usuario_user_repository.dart';

class UsuarioUserRepositoryImpl implements UsuarioUserRepository {
  final UsuarioApiClientUser apiClient;

  UsuarioUserRepositoryImpl(this.apiClient);

  @override
  Future<UsuarioUserResponse> getUsuarioCompletoById(int id) {
    return apiClient.getUsuarioCompletoById(id);
  }

  @override
    Future<UsuarioUserResponse> putUsuarioCompleto(int id, UsuarioDtoUser usuario, File? imagen) async {
    final usuarioJson = jsonEncode(usuario.toJson());
    MultipartFile? multipartFile;

    if (imagen != null) {
      multipartFile = await MultipartFile.fromFile(
        imagen.path,
        filename: imagen.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"), // <- CORREGIDO
      );
    }

    return apiClient.putUsuarioCompletoUser(id, usuarioJson, multipartFile);
  }

  @override
  Future<UsuarioIdMensajeUsuarioDtoResponse> buscarIdPorUsername(String userName){
    return apiClient.buscarIdPorUsername(userName);
  }
}