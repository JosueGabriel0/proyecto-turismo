import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/categoria_api_client.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/emprendimiento_api_client.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/familia_api_client.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/familia_categoria_api_client.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/lugar_api_client.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/rol_api_client.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/usuario_api_client.dart';
import 'package:turismo_flutter/features/admin/data/repositories/categoria_repository_impl.dart';
import 'package:turismo_flutter/features/admin/data/repositories/emprendimiento_repository_impl.dart';
import 'package:turismo_flutter/features/admin/data/repositories/familia_categoria_repository_impl.dart';
import 'package:turismo_flutter/features/admin/data/repositories/familia_repository_impl.dart';
import 'package:turismo_flutter/features/admin/data/repositories/lugar_repository_impl.dart';
import 'package:turismo_flutter/features/admin/data/repositories/rol_repository_impl.dart';
import 'package:turismo_flutter/features/admin/data/repositories/usuario_respository_impl.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/categoria_repository.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/emprendimiento_repository.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_categoria_repository.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_repository.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/rol_repository.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/usuario_repository.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/categoria/buscar_categorias_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/categoria/delete_categoria_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/categoria/get_categoria_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/categoria/get_categorias_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/categoria/post_categoria_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/categoria/put_categoria_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/emprendimiento/buscar_emprendimientos_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/emprendimiento/delete_emprendimiento_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/emprendimiento/get_emprendimiento_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/emprendimiento/get_emprendimientos_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/emprendimiento/post_emprendimiento_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/emprendimiento/put_emprendimiento_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/buscar_familias_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/delete_familia_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/get_familia_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/get_familias_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/post_familia_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/put_familia_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia_categoria/asociar_familia_categoria_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia_categoria/eliminar_relacion_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia_categoria/listar_relaciones_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia_categoria/obtener_por_id_categoria_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia_categoria/obtener_por_id_familia_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/lugar/buscar_lugares_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/lugar/create_lugar_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/lugar/delete_lugar_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/lugar/get_lugar_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/lugar/get_lugares_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/lugar/update_lugar_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/buscar_roles_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/create_rol_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/delete_rol_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/get_rol_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/get_roles_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/rol/update_rol_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/buscar_usuarios_completos_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/create_usuario_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/delete_usuario_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/get_usuario_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/get_usuarios_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/usuario/update_usuario_usecase.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia_categoria/familia_categoria_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';
import 'package:turismo_flutter/features/usuario/data/datasources/remote/reserva_api_client.dart';
import 'package:turismo_flutter/features/usuario/data/datasources/remote/usuario_api_client_user.dart';
import 'package:turismo_flutter/features/usuario/data/repositories/reserva_repository_impl.dart';
import 'package:turismo_flutter/features/usuario/data/repositories/usuario_user_repository_impl.dart';
import 'package:turismo_flutter/features/usuario/domain/repositories/reserva_repository.dart';
import 'package:turismo_flutter/features/usuario/domain/repositories/usuario_user_repository.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/reserva/crear_reserva_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/reserva/obtener_reserva_por_id_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/reserva/obtener_reservas_por_id_usuari_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/reserva/obtener_telefono_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/usuario/buscar_id_por_username_user_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/usuario/get_usuario_by_id_user_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/usuario/put_usuario_user_usecase.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_bloc.dart';

final getIt = GetIt.instance;

void injectUsuarioDependencies() {

  // ---------- USUARIO ----------
  getIt.registerLazySingleton<UsuarioApiClientUser>(
        () => UsuarioApiClientUser(getIt<Dio>()),
  );

  getIt.registerLazySingleton<UsuarioUserRepository>(
        () => UsuarioUserRepositoryImpl(getIt<UsuarioApiClientUser>()),
  );

  getIt.registerLazySingleton<GetUsuarioByIdUserUseCase>(
        () => GetUsuarioByIdUserUseCase(getIt<UsuarioUserRepository>()),
  );

  getIt.registerLazySingleton<PutUsuarioUserUseCase>(
        () => PutUsuarioUserUseCase(getIt<UsuarioUserRepository>()),
  );

  getIt.registerLazySingleton<BuscarIdPorUsernameUserUsecase>(
        () => BuscarIdPorUsernameUserUsecase(getIt<UsuarioUserRepository>()),
  );

  getIt.registerFactory<UsuarioUserBloc>(
        () => UsuarioUserBloc(
      getUsuarioByIdUserUseCase: getIt<GetUsuarioByIdUserUseCase>(),
      putUsuarioUserUseCase:  getIt<PutUsuarioUserUseCase>(),
      buscarIdPorUsernameUserUsecase: getIt<BuscarIdPorUsernameUserUsecase>(),
      tokenStorageService: getIt(),
    ),
  );

  // ---------- RESERVA ----------
  getIt.registerLazySingleton<ReservaApiClient>(
        () => ReservaApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ReservaRepository>(
        () => ReservaRepositoryImpl(getIt<ReservaApiClient>()),
  );

  getIt.registerLazySingleton<CrearReservaUseCase>(
        () => CrearReservaUseCase(getIt<ReservaRepository>()),
  );

  getIt.registerLazySingleton<ObtenerTelefonoUseCase>(
        () => ObtenerTelefonoUseCase(getIt<ReservaRepository>()),
  );

  getIt.registerLazySingleton<ObtenerReservasPorIdUsuariUsecase>(
        () => ObtenerReservasPorIdUsuariUsecase(getIt<ReservaRepository>()),
  );

  getIt.registerLazySingleton<ObtenerReservaPorIdUsecase>(
        () => ObtenerReservaPorIdUsecase(getIt<ReservaRepository>()),
  );

  getIt.registerFactory<ReservaBloc>(
        () => ReservaBloc(
          crearReservaUseCase: getIt<CrearReservaUseCase>(),
          obtenerTelefonoUseCase: getIt<ObtenerTelefonoUseCase>(),
          obtenerReservasPorIdUsuariUsecase: getIt<ObtenerReservasPorIdUsuariUsecase>(),
          obtenerReservaPorIdUsecase: getIt<ObtenerReservaPorIdUsecase>(),
    ),
  );
}