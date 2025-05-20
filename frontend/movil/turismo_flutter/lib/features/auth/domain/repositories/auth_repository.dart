import 'package:turismo_flutter/features/auth/data/models/login_dto.dart';
import 'package:turismo_flutter/features/auth/data/models/login_response.dart';
import 'package:turismo_flutter/features/auth/data/models/register_dto.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
  Future<LoginResponse> register(RegisterDto registerDto);
}