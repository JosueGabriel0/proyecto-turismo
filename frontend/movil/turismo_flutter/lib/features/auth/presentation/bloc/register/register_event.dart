import 'package:turismo_flutter/features/auth/data/models/register_dto.dart';

abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final RegisterDto registerDto;

  RegisterSubmitted({required this.registerDto});
}