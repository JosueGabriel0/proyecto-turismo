import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/file_api_client.dart';
import 'package:turismo_flutter/features/general/domain/repositories/file_repository.dart';

class FileRepositoryImpl implements FileRepository {
  final FileApiClient _fileApiClient;

  FileRepositoryImpl(this._fileApiClient);

  @override
  Future<Uint8List> downloadFile(String fileName) async {
    // Llamamos al método de la API que descarga el archivo
    final response = await _fileApiClient.downloadFile(fileName);

    // El archivo se devuelve como List<int>, convertimos eso a Uint8List
    return Uint8List.fromList(response.data);
  }
}