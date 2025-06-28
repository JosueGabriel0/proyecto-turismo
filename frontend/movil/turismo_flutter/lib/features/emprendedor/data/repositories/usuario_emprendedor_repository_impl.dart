import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart'; // <== ESTE ES EL IMPORT FALTANTE
import 'package:turismo_flutter/features/emprendedor/data/datasources/remote/usuario_emprendedor_api_client.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/usuario_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/usuario_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/usuario_id_mensaje_emprendedor_dto_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/usuario_emprendedor_repository.dart';

class UsuarioEmprendedorRepositoryImpl implements UsuarioEmprendedorRepository {
  final UsuarioEmprendedorApiClient apiClient;

  UsuarioEmprendedorRepositoryImpl(this.apiClient);

  @override
  Future<UsuarioEmprendedorResponse> getUsuarioCompletoById(int id) {
    return apiClient.getUsuarioCompletoById(id);
  }

  @override
  Future<UsuarioEmprendedorResponse> putUsuarioCompleto(int id, UsuarioEmprendedorDto usuario, File? imagen) async {
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
  Future<UsuarioIdMensajeEmprendedorDtoResponse> buscarIdPorUsername(String userName){
    return apiClient.buscarIdPorUsername(userName);
  }
}