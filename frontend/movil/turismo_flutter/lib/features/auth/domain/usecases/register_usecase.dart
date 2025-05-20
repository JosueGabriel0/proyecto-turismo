import 'package:turismo_flutter/features/auth/data/models/login_response.dart';
import 'package:turismo_flutter/features/auth/data/models/register_dto.dart';
import 'package:turismo_flutter/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<LoginResponse> execute(RegisterDto registerDto) async {
    return await authRepository.register(registerDto);
  }
}