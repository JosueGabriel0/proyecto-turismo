import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/auth/data/models/login_dto.dart';
import 'package:turismo_flutter/features/auth/domain/usecases/login_usecase.dart';
import 'package:turismo_flutter/features/auth/presentation/bloc/login/login_event.dart';
import 'package:turismo_flutter/features/auth/presentation/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    print("LoginBloc inicializado con loginUseCase: $loginUseCase");

    on<LoginSubmitted>((event, emit) async {
      print("Evento LoginSubmitted recibido con username: ${event.username}");
      emit(LoginLoading());

      try {
        final loginDto = LoginDto(username: event.username, password: event.password);
        print("Ejecutando loginUseCase con DTO: $loginDto");

        final response = await loginUseCase.execute(loginDto);

        final token = response.token; // Asumiendo que es así
        await TokenStorageService().saveToken(token);

        final role = getRoleFromToken(token) ?? "";

        print("Login exitoso, respuesta: $response");
        emit(LoginSuccess(role: role));
      } catch (e, stackTrace) {
        print("Error en loginUseCase: $e");
        print("StackTrace: $stackTrace");
        emit(LoginFailure("Ocurrió un error al iniciar sesión"));
      }
    });
  }
}