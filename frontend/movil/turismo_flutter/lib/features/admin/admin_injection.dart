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

  getIt.registerLazySingleton<BuscarRolesPorNombreUsecase>(
        () => BuscarRolesPorNombreUsecase(getIt<RolRepository>()),
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

  getIt.registerLazySingleton<BuscarUsuariosCompletosPorNombreUsecase>(
        () => BuscarUsuariosCompletosPorNombreUsecase(getIt<UsuarioRepository>()),
  );

  getIt.registerFactory<UsuarioBloc>(
        () => UsuarioBloc(
      getAllUsuariosUseCase: getIt<GetAllUsuariosUseCase>(),
      getUsuarioByIdUseCase: getIt<GetUsuarioByIdUseCase>(),
      createUsuarioUseCase: getIt<CreateUsuarioUseCase>(),
      updateUsuarioUseCase: getIt<UpdateUsuarioUseCase>(),
      deleteUsuarioUseCase: getIt<DeleteUsuarioUseCase>(),
          buscarUsuariosCompletosPorNombreUsecase: getIt<BuscarUsuariosCompletosPorNombreUsecase>(),
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

  getIt.registerLazySingleton<BuscarLugaresPorNombreUsecase>(
        () => BuscarLugaresPorNombreUsecase(getIt<LugarRepository>()),
  );

  getIt.registerFactory<LugarBloc>(
        () => LugarBloc(
      getLugaresUseCase: getIt<GetLugaresUseCase>(),
      getLugarByIdUseCase: getIt<GetLugarByIdUseCase>(),
      createLugarUsecase: getIt<CreateLugarUsecase>(),
      updateLugarUseCase: getIt<UpdateLugarUseCase>(),
      deleteLugarUseCase: getIt<DeleteLugarUseCase>(),
          buscarLugaresPorNombreUsecase: getIt<BuscarLugaresPorNombreUsecase>(),
    ),
  );

  // --------- FAMILIAS ---------
  getIt.registerLazySingleton<FamiliaApiClient>(
        () => FamiliaApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<FamiliaRepository>(
        () => FamiliaRepositoryImpl(getIt<FamiliaApiClient>()),
  );

  getIt.registerLazySingleton<GetFamiliasUsecase>(
        () => GetFamiliasUsecase(getIt<FamiliaRepository>()),
  );

  getIt.registerLazySingleton<GetFamiliaByIdUsecase>(
        () => GetFamiliaByIdUsecase(getIt<FamiliaRepository>()),
  );

  getIt.registerLazySingleton<PostFamiliaUsecase>(
        () => PostFamiliaUsecase(getIt<FamiliaRepository>()),
  );

  getIt.registerLazySingleton<PutFamiliaUseCase>(
        () => PutFamiliaUseCase(getIt<FamiliaRepository>()),
  );

  getIt.registerLazySingleton<DeleteFamiliaUsecase>(
        () => DeleteFamiliaUsecase(getIt<FamiliaRepository>()),
  );

  getIt.registerLazySingleton<BuscarFamiliasPorNombreUsecase>(
        () => BuscarFamiliasPorNombreUsecase(getIt<FamiliaRepository>()),
  );

  getIt.registerFactory<FamiliaBloc>(
        () => FamiliaBloc(
      getFamiliasUsecase: getIt<GetFamiliasUsecase>(),
      getFamiliaByIdUsecase: getIt<GetFamiliaByIdUsecase>(),
      postFamiliaUsecase: getIt<PostFamiliaUsecase>(),
      putFamiliaUseCase: getIt<PutFamiliaUseCase>(),
      deleteFamiliaUsecase: getIt<DeleteFamiliaUsecase>(),
          buscarFamiliasPorNombreUsecase: getIt<BuscarFamiliasPorNombreUsecase>(),
    ),
  );

  // --------- CATEGORIAS ---------
  getIt.registerLazySingleton<CategoriaApiClient>(
        () => CategoriaApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<CategoriaRepository>(
        () => CategoriaRepositoryImpl(getIt<CategoriaApiClient>()),
  );

  getIt.registerLazySingleton<GetCategoriasUsecase>(
        () => GetCategoriasUsecase(getIt<CategoriaRepository>()),
  );

  getIt.registerLazySingleton<GetCategoriaByIdUsecase>(
        () => GetCategoriaByIdUsecase(getIt<CategoriaRepository>()),
  );

  getIt.registerLazySingleton<PostCategoriaUsecase>(
        () => PostCategoriaUsecase(getIt<CategoriaRepository>()),
  );

  getIt.registerLazySingleton<PutCategoriaUsecase>(
        () => PutCategoriaUsecase(getIt<CategoriaRepository>()),
  );

  getIt.registerLazySingleton<DeleteCategoriaUseCase>(
        () => DeleteCategoriaUseCase(getIt<CategoriaRepository>()),
  );

  getIt.registerLazySingleton<BuscarCategoriasPorNombreUsecase>(
        () => BuscarCategoriasPorNombreUsecase(getIt<CategoriaRepository>()),
  );

  getIt.registerFactory<CategoriaBloc>(
        () => CategoriaBloc(
      getCategoriasUsecase: getIt<GetCategoriasUsecase>(),
      getCategoriaByIdUsecase: getIt<GetCategoriaByIdUsecase>(),
      postCategoriaUsecase: getIt<PostCategoriaUsecase>(),
      putCategoriaUsecase: getIt<PutCategoriaUsecase>(),
      deleteCategoriaUseCase: getIt<DeleteCategoriaUseCase>(),
          buscarCategoriasPorNombreUsecase: getIt<BuscarCategoriasPorNombreUsecase>()
    ),
  );

  // --------- FAMILIA-CATEGORIA ---------
  getIt.registerLazySingleton<FamiliaCategoriaApiClient>(
        () => FamiliaCategoriaApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<FamiliaCategoriaRepository>(
        () => FamiliaCategoriaRepositoryImpl(getIt<FamiliaCategoriaApiClient>()),
  );

  getIt.registerLazySingleton<AsociarFamiliaCategoriaUseCase>(
        () => AsociarFamiliaCategoriaUseCase(getIt<FamiliaCategoriaRepository>()),
  );

  getIt.registerLazySingleton<EliminarRelacionUsecase>(
        () => EliminarRelacionUsecase(getIt<FamiliaCategoriaRepository>()),
  );

  getIt.registerLazySingleton<ListarRelacionesUsecase>(
        () => ListarRelacionesUsecase(getIt<FamiliaCategoriaRepository>()),
  );

  getIt.registerLazySingleton<ObtenerPorIdCategoriaUsecase>(
        () => ObtenerPorIdCategoriaUsecase(getIt<FamiliaCategoriaRepository>()),
  );

  getIt.registerLazySingleton<ObtenerPorIdFamiliaUsecase>(
        () => ObtenerPorIdFamiliaUsecase(getIt<FamiliaCategoriaRepository>()),
  );

  getIt.registerFactory<FamiliaCategoriaBloc>(
        () => FamiliaCategoriaBloc(
      asociarFamiliaCategoriaUseCase: getIt<AsociarFamiliaCategoriaUseCase>(),
      eliminarRelacionUsecase: getIt<EliminarRelacionUsecase>(),
      listarRelacionesUsecase: getIt<ListarRelacionesUsecase>(),
      obtenerPorIdCategoriaUsecase: getIt<ObtenerPorIdCategoriaUsecase>(),
      obtenerPorIdFamiliaUsecase: getIt<ObtenerPorIdFamiliaUsecase>(),
    ),
  );

  // --------- EMPRENDIMIENTOS ---------
  getIt.registerLazySingleton<EmprendimientoApiClient>(
        () => EmprendimientoApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<EmprendimientoRepository>(
        () => EmprendimientoRepositoryImpl(getIt<EmprendimientoApiClient>()),
  );

  getIt.registerLazySingleton<GetEmprendimientosUsecase>(
        () => GetEmprendimientosUsecase(getIt<EmprendimientoRepository>()),
  );

  getIt.registerLazySingleton<GetEmprendimientoByIdUsecase>(
        () => GetEmprendimientoByIdUsecase(getIt<EmprendimientoRepository>()),
  );

  getIt.registerLazySingleton<PostEmprendimientoUsecase>(
        () => PostEmprendimientoUsecase(getIt<EmprendimientoRepository>()),
  );

  getIt.registerLazySingleton<PutEmprendimientoUsecase>(
        () => PutEmprendimientoUsecase(getIt<EmprendimientoRepository>()),
  );

  getIt.registerLazySingleton<DeleteEmprendimientoUseCase>(
        () => DeleteEmprendimientoUseCase(getIt<EmprendimientoRepository>()),
  );

  getIt.registerLazySingleton<BuscarEmprendimientosPorNombreUseCase>(
        () => BuscarEmprendimientosPorNombreUseCase(getIt<EmprendimientoRepository>()),
  );

  getIt.registerFactory<EmprendimientoBloc>(
        () => EmprendimientoBloc(
      getEmprendimientosUsecase: getIt<GetEmprendimientosUsecase>(),
      getEmprendimientoByIdUsecase: getIt<GetEmprendimientoByIdUsecase>(),
      postEmprendimientoUsecase: getIt<PostEmprendimientoUsecase>(),
      putEmprendimientoUsecase: getIt<PutEmprendimientoUsecase>(),
      deleteEmprendimientoUseCase: getIt<DeleteEmprendimientoUseCase>(),
          buscarEmprendimientosPorNombreUseCase: getIt<BuscarEmprendimientosPorNombreUseCase>(),
    ),
  );
}