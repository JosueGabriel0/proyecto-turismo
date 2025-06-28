import 'dart:io';

import 'package:turismo_flutter/features/admin/domain/repositories/file_admin_repository.dart';

class UploadFileAdminUsecase {
  final FileAdminRepository repository;

  UploadFileAdminUsecase(this.repository);

  /// Sube un archivo y retorna el nombre generado por el backend.
  Future<String> call({
    required File file,
    required String tipo,
  }) async {
    return await repository.uploadFile(imagen: file, tipo: tipo);
  }
}