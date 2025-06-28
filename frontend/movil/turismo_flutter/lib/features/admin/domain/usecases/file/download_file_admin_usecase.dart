import 'package:turismo_flutter/features/admin/domain/repositories/file_admin_repository.dart';

class DownloadFileAdminUsecase {
  final FileAdminRepository repository;

  DownloadFileAdminUsecase(this.repository);

  /// Descarga un archivo y retorna los bytes del contenido.
  Future<List<int>> call({
    required String tipo,
    required String filename,
  }) async {
    return await repository.downloadFile(tipo: tipo, filename: filename);
  }
}