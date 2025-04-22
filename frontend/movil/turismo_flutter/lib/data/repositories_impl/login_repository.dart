import 'package:dio/dio.dart';
import 'package:turismo_flutter/core/constants/constants.dart';
import '../models/login_dto.dart';
import '../models/login_response.dart';

class LoginRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrlDev));

  Future<LoginResponse> login(LoginDto dto) async {
    try {
      final response = await _dio.post("/auth/login", data: dto.toJson());
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Error al iniciar sesión: ${e.response?.data ?? e.message}");
    }
  }
}
