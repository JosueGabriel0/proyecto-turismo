import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/auth/domain/usecases/register_usecase.dart';
import 'package:turismo_flutter/features/auth/presentation/bloc/register/register_event.dart';
import 'package:turismo_flutter/features/auth/presentation/bloc/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase}) : super(RegisterInitial()) {

    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());

      try {
        final response = await registerUseCase.execute(event.registerDto);

        final token = response.token; // Asumiendo que es así
        await TokenStorageService().saveToken(token);

        final role = getRoleFromToken(token) ?? "";

        print("Register exitoso, respuesta: $response");
        emit(RegisterSuccess(message: "Register exitoso"));
      } catch (e, stackTrace) {
        print("Error en loginUseCase: $e");
        print("StackTrace: $stackTrace");
        emit(RegisterFailure("Ocurrió un error al registrarse"));
      }
    });
  }
}