import 'package:jwt_decoder/jwt_decoder.dart';

String? getRoleFromToken(String token) {
  try {
    final decodedToken = JwtDecoder.decode(token);
    return decodedToken['role']; // Cambia 'role' según el campo de tu JWT
  } catch (e) {
    return null;
  }
}

int? getIdUsuarioFromToken(String? token) {
  try {
    final decodedToken = JwtDecoder.decode(token!);
    return decodedToken['idUsuario']; // Asegúrate de que este sea el nombre exacto del campo en el token
  } catch (e) {
    return null;
  }
}
