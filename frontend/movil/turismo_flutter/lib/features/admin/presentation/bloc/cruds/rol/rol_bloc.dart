import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_dto.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/create_rol_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/delete_rol_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/get_rol_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/get_roles_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/update_rol_usecase.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_state.dart';

class RolBloc extends Bloc<RolEvent, RolState> {
  final CreateRolUseCase createRolUseCase;
  final GetRolesUseCase getRolesUseCase;
  final GetRolByIdUseCase getRolByIdUseCase;
  final UpdateRolUseCase updateRolUseCase;
  final DeleteRolUseCase deleteRolUseCase;

  RolBloc({
    required this.createRolUseCase,
    required this.getRolesUseCase,
    required this.getRolByIdUseCase,
    required this.updateRolUseCase,
    required this.deleteRolUseCase,
  }) : super(RolInitialState()) {
    on<GetRolesEvent>(_onGetRoles);
    on<GetRolByIdEvent>(_onGetRolById);
    on<CreateRolEvent>(_onCreateRol);
    on<UpdateRolEvent>(_onUpdateRol);
    on<DeleteRolEvent>(_onDeleteRol);
  }

  Future<void> _onGetRoles(GetRolesEvent event, Emitter<RolState> emit) async {
    print("Evento: Obtener Roles"); // Verifica si se está llamando
    emit(RolLoadingState());
    try {
      print("Antes de ejecutar getRolesUseCase.execute()");
      final roles = await getRolesUseCase.execute();
      print("Despues de ejecutar getRolesUseCase.execute()");
      emit(RolLoadedState(roles: roles));
      print("Roles cargados: $roles");
    } catch (e, stackTrace) {
         print("¡ERROR DETECTADO EN GetRoles!: $e");
         print("StackTrace: $stackTrace");

         if (e is DioError) {
          print("Código de estado error: ${e.response?.statusCode}");
          print("Mensaje de error: ${e.response?.statusMessage}");
          emit(RolErrorState(message: "Error: ${e.response?.statusCode} - ${e.response?.statusMessage}"));
         } else {
           emit(RolErrorState(message: e.toString()));
         }
}
  }

  Future<void> _onGetRolById(GetRolByIdEvent event, Emitter<RolState> emit) async {
    emit(RolLoadingState());
    try {
      final rol = await getRolByIdUseCase.execute(event.idRol);
      emit(RolLoadedState(roles: [rol]));
    } catch (e) {
      // Verificar si el error es de tipo DioError
      if (e is DioError) {
        print("Código de estado error: ${e.response?.statusCode}");
        print("Mensaje de error: ${e.response?.statusMessage}");
        emit(RolErrorState(message: "Error: ${e.response?.statusCode} - ${e.response?.statusMessage}"));
      } else {
        emit(RolErrorState(message: e.toString()));
      }
    }
  }

  Future<void> _onCreateRol(CreateRolEvent event, Emitter<RolState> emit) async {
    emit(RolLoadingState());
    try {
      await createRolUseCase.execute(event.rolDto);
      emit(RolCreateSuccessState());
      add(GetRolesEvent()); // Recargar roles después de crear
    } catch (e) {
      // Verificar si el error es de tipo DioError
      if (e is DioError) {
        print("Código de estado error: ${e.response?.statusCode}");
        print("Mensaje de error: ${e.response?.statusMessage}");
        emit(RolErrorState(message: "Error: ${e.response?.statusCode} - ${e.response?.statusMessage}"));
      } else {
        emit(RolErrorState(message: e.toString()));
      }
    }
  }

  Future<void> _onUpdateRol(UpdateRolEvent event, Emitter<RolState> emit) async {
    emit(RolLoadingState());
    try {
      await updateRolUseCase.execute(event.idRol, event.rolDto);
      emit(RolUpdateSuccessState());
      add(GetRolesEvent()); // Recargar roles después de actualizar
    } catch (e) {
      // Verificar si el error es de tipo DioError
      if (e is DioError) {
        print("Código de estado error: ${e.response?.statusCode}");
        print("Mensaje de error: ${e.response?.statusMessage}");
        emit(RolErrorState(message: "Error: ${e.response?.statusCode} - ${e.response?.statusMessage}"));
      } else {
        emit(RolErrorState(message: e.toString()));
      }
    }
  }

  Future<void> _onDeleteRol(DeleteRolEvent event, Emitter<RolState> emit) async {
    emit(RolLoadingState());
    try {
      await deleteRolUseCase.execute(event.idRol);
      emit(RolDeleteSuccessState());
      add(GetRolesEvent()); // Recargar roles después de eliminar
    } catch (e) {
      // Verificar si el error es de tipo DioError
      if (e is DioError) {
        print("Código de estado error: ${e.response?.statusCode}");
        print("Mensaje de error: ${e.response?.statusMessage}");
        emit(RolErrorState(message: "Error: ${e.response?.statusCode} - ${e.response?.statusMessage}"));
      } else {
        emit(RolErrorState(message: e.toString()));
      }
    }
  }
}