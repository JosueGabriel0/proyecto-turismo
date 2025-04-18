import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_flutter/data/repositories_impl/login_repository.dart';
import '../models/login_dto.dart';

class LoginService {
  final LoginRepository _repository = LoginRepository();

  Future<String?> loginAndSaveToken(LoginDto dto) async {
    final response = await _repository.login(dto);
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('auth_token', response.token);

    // Extraer y guardar el rol
    final role = getRoleFromJwt(response.token);

    // Extraer y guardar el idUsuario
    final idUsuario = getIdUsuarioFromJwt(response.token);
    if (idUsuario != null) {
      await prefs.setInt('idUsuario', idUsuario);
    }

    return role;
  }

  Future<String?> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  String? getRoleFromJwt(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final data = json.decode(payload);
      return data['role']; // Asegurate que en tu JWT el campo se llama 'role'
    } catch (e) {
      return null;
    }
  }

  int? getIdUsuarioFromJwt(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final data = json.decode(payload);

      return data['idUsuario'];
    } catch (e) {
      return null;
    }
  }


}
