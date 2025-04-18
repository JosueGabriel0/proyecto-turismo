import 'package:dio/dio.dart';
import 'package:turismo_flutter/data/models/rol_response.dart';

class RolRepository{
  final Dio _dio;

  RolRepository({String baseUrl = "http://172.25.160.1:8080"}): _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<RolResponse>> getRoles(String token) async {
    try{
      final response = await _dio.get(
          "/admin/rol",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
      );

      if(response.data is List){
        return rolResponseFromJson(response.data);
      } else {
        throw Exception("La respuesta no tiene el formato esperado");
      }
    } on DioException catch (e) {
      throw Exception("Error al obtener los roles: ${e.response?.data ?? e.message}");
    }
  }

  Future<RolResponse> getRolById(int idRol, String token) async {
    try{
      final response = await _dio.get(
        "/admin/rol/$idRol",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          }
        )
      );

      if(response.data is Map<String, dynamic>){
        return RolResponse.fromJson(response.data);
      } else {
        throw Exception("La respuesta no tiene el formato esperado");
      }
    } on DioException catch (e) {
      throw Exception("Error al obtener el rol por ID: ${e.response?.data ?? e.message}");
    }
  }
}