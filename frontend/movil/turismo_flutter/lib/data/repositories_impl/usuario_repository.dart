import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_flutter/core/constants/constants.dart';
import 'package:turismo_flutter/data/models/usuario_completo_dto.dart';
import 'package:turismo_flutter/data/models/usuario_completo_response.dart';

class UsuarioRepository {
  final Dio _dio;

  UsuarioRepository({String baseUrl = baseUrlDev})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<UsuarioCompletoResponse>> getUsuariosCompletos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    try {
      final response = await _dio.get(
        "/admin/usuarioCompleto",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data is List) {
        return response.data
            .map<UsuarioCompletoResponse>(
              (e) => UsuarioCompletoResponse.fromJson(e),
        )
            .toList();
      } else {
        throw Exception("La respuesta no tiene el formato esperado");
      }
    } on DioException catch (e) {
      throw Exception("Error al obtener los usuarios: ${e.response?.data ?? e.message}");
    }
  }

  Future<UsuarioCompletoResponse> getUsuarioPorId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    try {
      final response = await _dio.get(
        "/admin/usuarioCompleto/$id",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data is Map<String, dynamic>) {
        return UsuarioCompletoResponse.fromJson(response.data);
      } else {
        throw Exception("La respuesta no tiene el formato esperado");
      }
    } on DioException catch (e) {
      throw Exception("Error al obtener el usuario por ID: ${e.response?.data ?? e.message}");
    }
  }

  Future<UsuarioCompletoResponse> createUsuario(UsuarioCompletoDto usuarioCompletoDto) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    try {
      final response = await _dio.post(
        "/admin/usuarioCompleto",
        data: usuarioCompletoDto.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return UsuarioCompletoResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Error al crear el usuario: ${e.response?.data ?? e.message}");
    }
  }

  Future<UsuarioCompletoResponse> updateUsuario(int idUsuario, UsuarioCompletoDto usuarioCompletoDto) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    try {
      final response = await _dio.put(
        "/admin/usuarioCompleto/$idUsuario",
        data: usuarioCompletoDto.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data is Map<String, dynamic>) {
        return UsuarioCompletoResponse.fromJson(response.data);
      } else {
        throw Exception("La respuesta no tiene el formato esperado");
      }
    } on DioException catch (e) {
      throw Exception("Error al actualizar el usuario: ${e.response?.data ?? e.message}");
    }
  }

  Future<void> deleteUsuario(int idUsuario) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    try {
      await _dio.delete(
        "/admin/usuarioCompleto/$idUsuario",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } on DioException catch (e) {
      throw Exception("Error al eliminar el usuario: ${e.response?.data ?? e.message}");
    }
  }
}