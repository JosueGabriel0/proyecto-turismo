import 'package:turismo_flutter/features/auth/data/models/login_dto.dart';
import 'package:turismo_flutter/features/auth/data/models/login_response.dart';
import 'package:turismo_flutter/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<LoginResponse> execute(LoginDto loginDto) async {
    return await authRepository.login(loginDto);
  }
}