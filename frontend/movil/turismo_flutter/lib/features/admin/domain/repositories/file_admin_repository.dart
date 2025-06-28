import 'dart:io';

abstract class FileAdminRepository {
  /// Sube un archivo al servidor y devuelve el nombre generado.
  Future<String> uploadFile({
    required File imagen,
    required String tipo,
  });

  /// Descarga un archivo como lista de bytes.
  Future<List<int>> downloadFile({
    required String tipo,
    required String filename,
  });
}