import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart'; // <== ESTE ES EL IMPORT FALTANTE
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/usuario_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_id_mensaje_dto_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/usuario_repository.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  final UsuarioApiClient apiClient;

  UsuarioRepositoryImpl(this.apiClient);

  @override
  Future<List<UsuarioCompletoResponse>> getUsuariosCompleto() {
    return apiClient.getUsuariosCompleto();
  }

  @override
  Future<UsuarioCompletoResponse> getUsuarioCompletoById(int id) {
    return apiClient.getUsuarioCompletoById(id);
  }

  @override
  Future<UsuarioCompletoResponse> postUsuarioCompleto(UsuarioCompletoDto usuario, File? imagen) async {
    final usuarioJson = jsonEncode(usuario.toJson());
    MultipartFile? multipartFile;

    if (imagen != null) {
      multipartFile = await MultipartFile.fromFile(
        imagen.path,
        filename: imagen.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"), // <- CORREGIDO
      );
    }

    return apiClient.postUsuarioCompleto(usuarioJson, multipartFile);
  }

  @override
  Future<UsuarioCompletoResponse> putUsuarioCompleto(int id, UsuarioCompletoDto usuario, File? imagen) async {
    final usuarioJson = jsonEncode(usuario.toJson());
    MultipartFile? multipartFile;

    if (imagen != null) {
      multipartFile = await MultipartFile.fromFile(
        imagen.path,
        filename: imagen.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"), // <- CORREGIDO
      );
    }

    return apiClient.putUsuarioCompleto(id, usuarioJson, multipartFile);
  }

  @override
  Future<void> deleteUsuarioCompleto(int id) {
    return apiClient.deleteUsuarioCompleto(id);
  }

  @override
  Future<List<UsuarioCompletoResponse>> buscarUsuariosCompletosPorNombre(String username) {
    return apiClient.buscarUsuariosPorNombre(username);
  }

  @override
  Future<UsuarioIdMensajeDtoResponse> buscarIdPorUsername(String userName){
    return apiClient.buscarIdPorUsername(userName);
  }
}