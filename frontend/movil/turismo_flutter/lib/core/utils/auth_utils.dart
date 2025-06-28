import 'package:jwt_decoder/jwt_decoder.dart';

String? getRoleFromToken(String token) {
  try {
    final decodedToken = JwtDecoder.decode(token);
    return decodedToken['role'];
  } catch (e) {
    return null;
  }
}

int? getIdUsuarioFromToken(String? token) {
  try {
    final decodedToken = JwtDecoder.decode(token!);
    return decodedToken['idUsuario'];
  } catch (e) {
    return null;
  }
}

String? getUsernameFromToken(String? token) {
  try {
    final decodedToken = JwtDecoder.decode(token!);
    return decodedToken['sub']; // "sub" representa el username en tu JWT
  } catch (e) {
    return null;
  }
}