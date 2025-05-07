import 'dart:typed_data';

abstract class FileRepository {
  Future<Uint8List> downloadFile(String fileName);
}