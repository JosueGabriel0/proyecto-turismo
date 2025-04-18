import 'package:dio/dio.dart';
import 'package:turismo_flutter/data/models/usuario_completo_response.dart';

class UsuarioRepository {
  final Dio _dio;

  // Constructor que permite pasar la URL base de manera flexible.
  UsuarioRepository({String baseUrl = "http://172.25.160.1:8080"})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<UsuarioCompletoResponse>> getUsuariosCompletos(String token) async {
    try {
      final response = await _dio.get(
        "/admin/usuarioCompleto",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Verificar que la respuesta tiene los datos esperados
      if (response.data is List) {
        return usuarioCompletoResponseFromJson(response.data);
      } else {
        throw Exception("La respuesta no tiene el formato esperado");
      }
    } on DioException catch (e) {
      throw Exception("Error al obtener los usuarios: ${e.response?.data ?? e.message}");
    }
  }

  Future<UsuarioCompletoResponse> getUsuarioPorId(int id, String token) async {
    try {
      final response = await _dio.get(
        "/admin/usuarioCompleto/$id",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Verificar que la respuesta tiene los datos esperados
      if (response.data is Map<String, dynamic>) {
        return UsuarioCompletoResponse.fromJson(response.data);
      } else {
        throw Exception("La respuesta no tiene el formato esperado");
      }
    } on DioException catch (e) {
      throw Exception("Error al obtener el usuario por ID: ${e.response?.data ?? e.message}");
    }
  }
}
