import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:turismo_flutter/features/auth/data/models/login_dto.dart';
import 'package:turismo_flutter/features/auth/data/models/login_response.dart';
import 'package:turismo_flutter/features/auth/data/models/register_dto.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/auth/login")
  Future<LoginResponse> login(@Body() LoginDto loginDto);

  @POST("/auth/register")
  Future<LoginResponse> register(@Body() RegisterDto registerDto);
}