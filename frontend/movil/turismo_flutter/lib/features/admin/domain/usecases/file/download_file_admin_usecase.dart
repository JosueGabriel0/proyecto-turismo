import 'dart:typed_data';
import 'package:turismo_flutter/features/admin/domain/repositories/file_admin_repository.dart';

class DownloadFileAdminUsecase {
  final FileAdminRepository repository;

  DownloadFileAdminUsecase(this.repository);

  /// Descarga un archivo y retorna los bytes del contenido como Uint8List.
  Future<Uint8List> call({
    required String tipo,
    required String filename,
  }) async {
    final bytes = await repository.downloadFile(tipo: tipo, filename: filename);
    return Uint8List.fromList(bytes); // ✅ conversión explícita
  }
}