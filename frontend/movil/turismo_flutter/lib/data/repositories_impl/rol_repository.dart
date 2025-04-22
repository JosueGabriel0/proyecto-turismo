import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_flutter/core/constants/constants.dart';
import 'package:turismo_flutter/data/models/rol_dto.dart';
import 'package:turismo_flutter/data/models/rol_response.dart';

class RolRepository {
  final Dio _dio;

  RolRepository({String baseUrl = baseUrlDev})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<RolResponse>> getRoles() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    try {
      final response = await _dio.get(
        "/admin/rol",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data is List) {
        return (response.data as List)
            .map((item) => RolResponse.fromJson(item))
            .toList();
      } else {
        throw Exception("La respuesta no tiene el formato esperado");
      }
    } on DioException catch (e) {
      throw Exception("Error al obtener los roles: ${e.response?.data ?? e.message}");
    }
  }

  Future<RolResponse> getRolById(int idRol) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    try {
      final response = await _dio.get(
        "/admin/rol/$idRol",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data is Map) {
        return RolResponse.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception("La respuesta no tiene el formato esperado");
      }
    } on DioException catch (e) {
      throw Exception("Error al obtener el rol por ID: ${e.response?.data ?? e.message}");
    }
  }

  Future<void> deleteRol(int idRol) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    try {
      await _dio.delete(
        "/admin/rol/$idRol",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } on DioException catch (e) {
      throw Exception("Error al eliminar el rol: ${e.response?.data ?? e.message}");
    }
  }

  Future<RolResponse> createRol(RolDto rolDto) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    try {
      final response = await _dio.post(
        "/admin/rol",
        data: rolDto.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Aquí mapeamos la respuesta para devolver un objeto RolResponse
      return RolResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Error al crear el rol: ${e.response?.data ?? e.message}");
    }
  }

  // Método para actualizar un rol
  Future<RolResponse> updateRol(int idRol, RolDto rolDto) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    try {
      final response = await _dio.put(
        "/admin/rol/$idRol", // URL para la actualización del rol
        data: rolDto.toJson(), // Los datos que queremos actualizar
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Asegúrate de que la respuesta sea de tipo Map<String, dynamic>
      if (response.data is Map<String, dynamic>) {
        return RolResponse.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception("La respuesta no tiene el formato esperado");
      }
    } on DioException catch (e) {
      throw Exception("Error al actualizar el rol: ${e.response?.data ?? e.message}");
    }
  }
}