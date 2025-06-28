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
import 'package:turismo_flutter/features/emprendedor/data/datasources/remote/emprendimiento_emprendedor_api_client.dart';
import 'package:turismo_flutter/features/emprendedor/data/datasources/remote/reserva_emprendedor_api_client.dart';
import 'package:turismo_flutter/features/emprendedor/data/datasources/remote/servicio_turistico_emprendedor_api_client.dart';
import 'package:turismo_flutter/features/emprendedor/data/datasources/remote/usuario_emprendedor_api_client.dart';
import 'package:turismo_flutter/features/emprendedor/data/repositories/emprendimiento_emprendedor_repository_impl.dart';
import 'package:turismo_flutter/features/emprendedor/data/repositories/reserva_emprendedor_repository_impl.dart';
import 'package:turismo_flutter/features/emprendedor/data/repositories/servicio_turistico_emprendedor_repository_impl.dart';
import 'package:turismo_flutter/features/emprendedor/data/repositories/usuario_emprendedor_repository_impl.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/emprendimiento_emprendedor_repository.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/reserva_emprendedor_repository.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/servicio_turistico_emprendedor_repository.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/usuario_emprendedor_repository.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/emprendimiento/get_emprendimiento_by_id_usuario_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/emprendimiento/update_emprendimiento_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/reserva/actualizar_reserva_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/reserva/crear_reserva_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/reserva/obtener_reserva_por_id_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/reserva/obtener_reservas_por_emprendimiento_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/servicio_turistico/buscar_servicios_turisticos_por_nombre_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/servicio_turistico/delete_servicio_turistico_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/servicio_turistico/get_servicio_turistico_by_id_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/servicio_turistico/get_servicios_turisticos_por_id_emprendimiento_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/servicio_turistico/post_servicio_turistico_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/servicio_turistico/put_servicio_turistico_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/usuario/buscar_id_por_username_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/usuario/get_usuario_by_id_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/domain/usecases/usuario/put_usuario_emprendedor_usecase.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/emprendimiento/emprendimiento_emprendedor_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/reserva/reserva_emprendedor_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/servicio_turistico/servicio_turistico_emprendedor_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/usuario/usuario_emprendedor_bloc.dart';
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
import 'package:turismo_flutter/features/usuario/domain/usecases/usuario/get_usuario_by_id_user_usecase.dart';
import 'package:turismo_flutter/features/usuario/domain/usecases/usuario/put_usuario_user_usecase.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_bloc.dart';

final getIt = GetIt.instance;

void injectEmprendedorDependencies() {

  // ---------- USUARIO ----------
  getIt.registerLazySingleton<UsuarioEmprendedorApiClient>(
        () => UsuarioEmprendedorApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<UsuarioEmprendedorRepository>(
        () => UsuarioEmprendedorRepositoryImpl(getIt<UsuarioEmprendedorApiClient>()),
  );

  getIt.registerLazySingleton<GetUsuarioByIdEmprendedorUsecase>(
        () => GetUsuarioByIdEmprendedorUsecase(getIt<UsuarioEmprendedorRepository>()),
  );

  getIt.registerLazySingleton<PutUsuarioEmprendedorUsecase>(
        () => PutUsuarioEmprendedorUsecase(getIt<UsuarioEmprendedorRepository>()),
  );

  getIt.registerLazySingleton<BuscarIdPorUsernameEmprendedorUsecase>(
        () => BuscarIdPorUsernameEmprendedorUsecase(getIt<UsuarioEmprendedorRepository>()),
  );

  getIt.registerFactory<UsuarioEmprendedorBloc>(
        () => UsuarioEmprendedorBloc(
      getUsuarioByIdEmprendedorUsecase: getIt<GetUsuarioByIdEmprendedorUsecase>(),
      putUsuarioEmprendedorUsecase:  getIt<PutUsuarioEmprendedorUsecase>(),
      buscarIdPorUsernameEmprendedorUsecase: getIt<BuscarIdPorUsernameEmprendedorUsecase>(),
      tokenStorageService: getIt(),
    ),
  );

    // ---------- SERVICIO TURISTICO ----------
  getIt.registerLazySingleton<ServicioTuristicoEmprendedorApiClient>(
        () => ServicioTuristicoEmprendedorApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ServicioTuristicoEmprendedorRepository>(
        () => ServicioTuristicoEmprendedorRepositoryImpl(getIt<ServicioTuristicoEmprendedorApiClient>()),
  );

  getIt.registerLazySingleton<BuscarServiciosTuristicosPorNombreEmprendedorUsecase>(
        () => BuscarServiciosTuristicosPorNombreEmprendedorUsecase(getIt<ServicioTuristicoEmprendedorRepository>()),
  );

  getIt.registerLazySingleton<DeleteServicioTuristicoEmprendedorUsecase>(
        () => DeleteServicioTuristicoEmprendedorUsecase(getIt<ServicioTuristicoEmprendedorRepository>()),
  );

  getIt.registerLazySingleton<GetServicioTuristicoByIdEmprendedorUsecase>(
        () => GetServicioTuristicoByIdEmprendedorUsecase(getIt<ServicioTuristicoEmprendedorRepository>()),
  );

  getIt.registerLazySingleton<GetServiciosTuristicosPorIdEmprendimientoEmprendedorUsecase>(
        () => GetServiciosTuristicosPorIdEmprendimientoEmprendedorUsecase(getIt<ServicioTuristicoEmprendedorRepository>()),
  );

  getIt.registerLazySingleton<PostServicioTuristicoEmprendedorUsecase>(
        () => PostServicioTuristicoEmprendedorUsecase(getIt<ServicioTuristicoEmprendedorRepository>()),
  );

  getIt.registerLazySingleton<PutServicioTuristicoEmprendedorUsecase>(
        () => PutServicioTuristicoEmprendedorUsecase(getIt<ServicioTuristicoEmprendedorRepository>()),
  );

  getIt.registerFactory<ServicioTuristicoEmprendedorBloc>(
        () => ServicioTuristicoEmprendedorBloc(
      actualizar: getIt<PutServicioTuristicoEmprendedorUsecase>(),
      buscarPorNombre: getIt<BuscarServiciosTuristicosPorNombreEmprendedorUsecase>(),
          crear: getIt<PostServicioTuristicoEmprendedorUsecase>(),
          eliminar: getIt<DeleteServicioTuristicoEmprendedorUsecase>(),
          obtenerPorEmprendimiento: getIt<GetServiciosTuristicosPorIdEmprendimientoEmprendedorUsecase>(),
          obtenerPorId: getIt<GetServicioTuristicoByIdEmprendedorUsecase>(),
        )
  );

  // ---------- EMPRENDIMIENTO ----------
  getIt.registerLazySingleton<EmprendimientoEmprendedorApiClient>(
        () => EmprendimientoEmprendedorApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<EmprendimientoEmprendedorRepository>(
        () => EmprendimientoEmprendedorRepositoryImpl(getIt<EmprendimientoEmprendedorApiClient>()),
  );

  getIt.registerLazySingleton<GetEmprendimientoByIdUsuarioEmprendedorUsecase>(
        () => GetEmprendimientoByIdUsuarioEmprendedorUsecase(getIt<EmprendimientoEmprendedorRepository>()),
  );

  getIt.registerLazySingleton<UpdateEmprendimientoEmprendedorUsecase>(
        () => UpdateEmprendimientoEmprendedorUsecase(getIt<EmprendimientoEmprendedorRepository>()),
  );

  getIt.registerFactory<EmprendimientoEmprendedorBloc>(
          () => EmprendimientoEmprendedorBloc(
        getUseCase: getIt<GetEmprendimientoByIdUsuarioEmprendedorUsecase>(),
            updateUseCase: getIt<UpdateEmprendimientoEmprendedorUsecase>(),
      )
  );

  // ---------- EMPRENDIMIENTO ----------
  getIt.registerLazySingleton<ReservaEmprendedorApiClient>(
        () => ReservaEmprendedorApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ReservaEmprendedorRepository>(
        () => ReservaEmprendedorRepositoryImpl(getIt<ReservaEmprendedorApiClient>()),
  );

  getIt.registerLazySingleton<ActualizarReservaEmprendedorUsecase>(
        () => ActualizarReservaEmprendedorUsecase(getIt<ReservaEmprendedorRepository>()),
  );

  getIt.registerLazySingleton<CrearReservaEmprendedorUsecase>(
        () => CrearReservaEmprendedorUsecase(getIt<ReservaEmprendedorRepository>()),
  );

  getIt.registerLazySingleton<ObtenerReservaPorIdUseCase>(
        () => ObtenerReservaPorIdUseCase(getIt<ReservaEmprendedorRepository>()),
  );

  getIt.registerLazySingleton<ObtenerReservasPorEmprendimientoUseCase>(
        () => ObtenerReservasPorEmprendimientoUseCase(getIt<ReservaEmprendedorRepository>()),
  );

  getIt.registerFactory<ReservaEmprendedorBloc>(
          () => ReservaEmprendedorBloc(
        actualizarReservaEmprendedorUsecase: getIt<ActualizarReservaEmprendedorUsecase>(),
        crearReservaEmprendedorUsecase: getIt<CrearReservaEmprendedorUsecase>(),
            obtenerReservaPorIdUseCase: getIt<ObtenerReservaPorIdUseCase>(),
            obtenerReservasPorEmprendimientoUseCase: getIt<ObtenerReservasPorEmprendimientoUseCase>(),
      )
  );
}