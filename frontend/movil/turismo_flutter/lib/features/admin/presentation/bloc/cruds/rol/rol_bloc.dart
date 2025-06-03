import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/buscar_roles_por_nombre_usecase.dart';
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
  final BuscarRolesPorNombreUsecase buscarRolesPorNombreUsecase;

  RolBloc({
    required this.createRolUseCase,
    required this.getRolesUseCase,
    required this.getRolByIdUseCase,
    required this.updateRolUseCase,
    required this.deleteRolUseCase,
    required this.buscarRolesPorNombreUsecase,
  }) : super(RolInitialState()) {
    on<GetRolesEvent>(_onGetRoles);
    on<GetRolByIdEvent>(_onGetRolById);
    on<CreateRolEvent>(_onCreateRol);
    on<UpdateRolEvent>(_onUpdateRol);
    on<DeleteRolEvent>(_onDeleteRol);
    on<BuscarRolPorNombreEvent>(
      _onBuscarRolesPorNombre,
      transformer: debounceRestartable(const Duration(milliseconds: 300)),
    );
  }

  Future<void> _onGetRoles(GetRolesEvent event, Emitter<RolState> emit) async {
    emit(RolLoadingState());
    try {
      final roles = await getRolesUseCase.execute();
      emit(RolLoadedState(roles: roles));
    } catch (e, stackTrace) {
      print("Error en GetRoles: $e");
      print("StackTrace: $stackTrace");
      if (e is DioError) {
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
      if (e is DioError) {
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
      add(GetRolesEvent());
    } catch (e) {
      if (e is DioError) {
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
      add(GetRolesEvent());
    } catch (e) {
      if (e is DioError) {
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
      add(GetRolesEvent());
    } catch (e) {
      if (e is DioError) {
        emit(RolErrorState(message: "Error: ${e.response?.statusCode} - ${e.response?.statusMessage}"));
      } else {
        emit(RolErrorState(message: e.toString()));
      }
    }
  }

  Future<void> _onBuscarRolesPorNombre(
      BuscarRolPorNombreEvent event,
      Emitter<RolState> emit,
      ) async {
    try {
      final resultados = await buscarRolesPorNombreUsecase(event.nombre);
      emit(RolLoadedState(roles: resultados));
    } catch (e, stackTrace) {
      print("🔴 Error al buscar roles: $e");
      print("🔍 StackTrace:\n$stackTrace");
      emit(RolErrorState(message: "Error al buscar roles: $e"));
    }
  }

  EventTransformer<T> debounceRestartable<T>(Duration duration) {
    return (events, mapper) => events
        .debounceTime(duration)
        .switchMap(mapper); // evita búsquedas obsoletas
  }
}