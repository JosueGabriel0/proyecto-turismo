import 'dart:typed_data';
import 'package:turismo_flutter/features/general/domain/repositories/file_repository.dart';

class DownloadFileUseCase {
  final FileRepository _fileRepository;

  // Inyección de dependencias del repositorio de archivos
  DownloadFileUseCase(this._fileRepository);

  // Método para descargar el archivo, devuelve un Uint8List
  Future<Uint8List> execute(String fileName) async {
    try {
      // Llamamos al repositorio para obtener el archivo
      final fileData = await _fileRepository.downloadFile(fileName);

      return fileData;
    } catch (e) {
      // Aquí puedes manejar errores de descarga
      rethrow;
    }
  }
}