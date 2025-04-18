import 'package:dio/dio.dart';
import '../models/login_dto.dart';
import '../models/login_response.dart';

class LoginRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://172.25.160.1:8080"));

  Future<LoginResponse> login(LoginDto dto) async {
    try {
      final response = await _dio.post("/auth/login", data: dto.toJson());
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Error al iniciar sesión: ${e.response?.data ?? e.message}");
    }
  }
}
