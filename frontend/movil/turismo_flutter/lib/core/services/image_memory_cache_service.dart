import 'dart:typed_data';

class ImageMemoryCacheService {
  static final ImageMemoryCacheService _instance = ImageMemoryCacheService._internal();
  factory ImageMemoryCacheService() => _instance;
  ImageMemoryCacheService._internal();

  final Map<String, Uint8List> _cache = {};

  Uint8List? get(String fileName) => _cache[fileName];

  void set(String fileName, Uint8List bytes) {
    _cache[fileName] = bytes;
  }

  bool contains(String fileName) => _cache.containsKey(fileName);
}