import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/file_admin_api_client.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/file_admin_repository.dart';
import 'package:http_parser/http_parser.dart';

class FileAdminRepositoryImpl implements FileAdminRepository {
  final FileAdminApiClient apiClient;

  FileAdminRepositoryImpl(this.apiClient);

  @override
  Future<String> uploadFile({
    required File imagen,
    required String tipo,
  }) async {
    try {
      MultipartFile? multipartFile;

      if (imagen != null) {
        multipartFile = await MultipartFile.fromFile(
          imagen.path,
          filename: imagen.uri.pathSegments.last,
          contentType: MediaType("image", "jpeg"), // <- CORREGIDO
        );
      }
      return await apiClient.uploadFile(multipartFile, tipo);
    } catch (e) {
      throw Exception("Error al subir archivo: $e");
    }
  }

  @override
  Future<Uint8List> downloadFile({
    required String tipo,
    required String filename,
  }) async {
    try {
      return await apiClient.downloadFile(tipo, filename); // <- directo
    } catch (e) {
      throw Exception("Error al descargar archivo: $e");
    }
  }
}