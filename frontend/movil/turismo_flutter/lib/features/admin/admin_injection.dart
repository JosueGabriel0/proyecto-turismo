import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/lugar_api_client.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/rol_api_client.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/usuario_api_client.dart';
import 'package:turismo_flutter/features/admin/data/repositories/lugar_repository_impl.dart';
import 'package:turismo_flutter/features/admin/data/repositories/rol_repository_impl.dart';
import 'package:turismo_flutter/features/admin/data/repositories/usuario_respository_impl.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/rol_repository.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/usuario_repository.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/lugar/create_lugar_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/lugar/delete_lugar_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/lugar/get_lugar_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/lugar/get_lugares_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/lugar/update_lugar_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/create_rol_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/delete_rol_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/get_rol_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/get_roles_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/update_rol_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/create_usuario_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/delete_usuario_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/get_usuario_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/get_usuarios_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/update_usuario_usecase.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';

final getIt = GetIt.instance;

void injectAdminDependencies() {
  // ApiClient para CRUD de roles usando Dio con interceptor
  getIt.registerLazySingleton<RolApiClient>(
        () => RolApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<RolRepository>(
        () => RolRepositoryImpl(rolApiClient: getIt<RolApiClient>()),
  );

  getIt.registerLazySingleton<CreateRolUseCase>(
        () => CreateRolUseCase(rolRepository: getIt<RolRepository>()),
  );

  getIt.registerLazySingleton<GetRolesUseCase>(
        () => GetRolesUseCase(rolRepository: getIt<RolRepository>()),
  );

  getIt.registerLazySingleton<UpdateRolUseCase>(
        () => UpdateRolUseCase(rolRepository: getIt<RolRepository>()),
  );

  getIt.registerLazySingleton<DeleteRolUseCase>(
        () => DeleteRolUseCase(rolRepository: getIt<RolRepository>()),
  );

  getIt.registerLazySingleton<GetRolByIdUseCase>(
        () => GetRolByIdUseCase(rolRepository: getIt<RolRepository>()),
  );

  // ---------- USUARIO ----------
  getIt.registerLazySingleton<UsuarioApiClient>(
        () => UsuarioApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<UsuarioRepository>(
        () => UsuarioRepositoryImpl(getIt<UsuarioApiClient>()),
  );

  getIt.registerLazySingleton<GetAllUsuariosUseCase>(
        () => GetAllUsuariosUseCase(getIt<UsuarioRepository>()),
  );

  getIt.registerLazySingleton<GetUsuarioByIdUseCase>(
        () => GetUsuarioByIdUseCase(getIt<UsuarioRepository>()),
  );

  getIt.registerLazySingleton<CreateUsuarioUseCase>(
        () => CreateUsuarioUseCase(getIt<UsuarioRepository>()),
  );

  getIt.registerLazySingleton<UpdateUsuarioUseCase>(
        () => UpdateUsuarioUseCase(getIt<UsuarioRepository>()),
  );

  getIt.registerLazySingleton<DeleteUsuarioUseCase>(
        () => DeleteUsuarioUseCase(getIt<UsuarioRepository>()),
  );

  getIt.registerFactory<UsuarioBloc>(
        () => UsuarioBloc(
      getAllUsuariosUseCase: getIt<GetAllUsuariosUseCase>(),
      getUsuarioByIdUseCase: getIt<GetUsuarioByIdUseCase>(),
      createUsuarioUseCase: getIt<CreateUsuarioUseCase>(),
      updateUsuarioUseCase: getIt<UpdateUsuarioUseCase>(),
      deleteUsuarioUseCase: getIt<DeleteUsuarioUseCase>(),
          tokenStorageService: getIt(),
    ),
  );

  // --------- LUGAR ---------
  getIt.registerLazySingleton<LugarApiClient>(
        () => LugarApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<LugarRepository>(
        () => LugarRepositoryImpl(getIt<LugarApiClient>()),
  );

  getIt.registerLazySingleton<GetLugaresUseCase>(
        () => GetLugaresUseCase(getIt<LugarRepository>()),
  );

  getIt.registerLazySingleton<GetLugarByIdUseCase>(
        () => GetLugarByIdUseCase(getIt<LugarRepository>()),
  );

  getIt.registerLazySingleton<CreateLugarUsecase>(
        () => CreateLugarUsecase(getIt<LugarRepository>()),
  );

  getIt.registerLazySingleton<UpdateLugarUseCase>(
        () => UpdateLugarUseCase(getIt<LugarRepository>()),
  );

  getIt.registerLazySingleton<DeleteLugarUseCase>(
        () => DeleteLugarUseCase(getIt<LugarRepository>()),
  );

  getIt.registerFactory<LugarBloc>(
        () => LugarBloc(
      getLugaresUseCase: getIt<GetLugaresUseCase>(),
      getLugarByIdUseCase: getIt<GetLugarByIdUseCase>(),
      createLugarUsecase: getIt<CreateLugarUsecase>(),
      updateLugarUseCase: getIt<UpdateLugarUseCase>(),
      deleteLugarUseCase: getIt<DeleteLugarUseCase>(),
    ),
  );
}