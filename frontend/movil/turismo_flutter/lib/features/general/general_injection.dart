import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/familia_categoria_api_client.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/categoria/get_categoria_by_id_usecase.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/categoria_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/emprendimiento_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/familia_categoria_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/familia_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/file_api_client.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/lugar_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/servicio_turistico_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/ubicacion_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/repositories/categoria_general_repository_impl.dart';
import 'package:turismo_flutter/features/general/data/repositories/emprendimiento_general_repository_impl.dart';
import 'package:turismo_flutter/features/general/data/repositories/familia_categoria_general_repository_impl.dart';
import 'package:turismo_flutter/features/general/data/repositories/familia_general_repository_impl.dart';
import 'package:turismo_flutter/features/general/data/repositories/file_repository_impl.dart';
import 'package:turismo_flutter/features/general/data/repositories/lugar_general_repository_impl.dart';
import 'package:turismo_flutter/features/general/data/repositories/servicio_turistico_general_repository_impl.dart';
import 'package:turismo_flutter/features/general/data/repositories/ubicacion_repository_impl.dart';
import 'package:turismo_flutter/features/general/domain/repositories/categoria_general_repository.dart';
import 'package:turismo_flutter/features/general/domain/repositories/emprendimiento_general_repository.dart';
import 'package:turismo_flutter/features/general/domain/repositories/familia_categoria_general_repository.dart';
import 'package:turismo_flutter/features/general/domain/repositories/familia_general_repository.dart';
import 'package:turismo_flutter/features/general/domain/repositories/file_repository.dart';
import 'package:turismo_flutter/features/general/domain/repositories/lugar_general_respository.dart';
import 'package:turismo_flutter/features/general/domain/repositories/servicio_turistico_general_repository.dart';
import 'package:turismo_flutter/features/general/domain/repositories/ubicacion_repository.dart';
import 'package:turismo_flutter/features/general/domain/usecases/categoria/buscar_categorias_por_nombre_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/categoria/get_categoria_by_id_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/categoria/get_categorias_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/emprendimiento/buscar_emprendimientos_por_nombre_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/emprendimiento/get_emprendimiento_by_id_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/emprendimiento/get_emprendimientos_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia/buscar_familias_por_nombre_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia/get_familia_by_id_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia/get_familias_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia_categoria/get_emprendimientos_por_familia_categoria_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia_categoria/listar_relaciones_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia_categoria/obtener_por_id_categoria_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia_categoria/obtener_por_id_familia_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/file/download_file_usecase.dart';
import 'package:turismo_flutter/features/general/domain/usecases/lugar/buscar_lugares_por_nombre_general_usecase.dart';
import 'package:turismo_flutter/features/general/domain/usecases/lugar/get_familias_por_lugar_general_usecase.dart';
import 'package:turismo_flutter/features/general/domain/usecases/lugar/get_lugares_general_usecase.dart';
import 'package:turismo_flutter/features/general/domain/usecases/servicio_turistico/get_servicios_por_emprendimiento_usecase.dart';
import 'package:turismo_flutter/features/general/domain/usecases/ubicacion/obtener_ubicaciones_usecase.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/lugar/lugar_general_event.dart';

final getIt = GetIt.instance;

void injectGeneralDependencies() {
  // ---------- FILE DOWNLOAD ----------
  // Registra el FileApiClient, Repositorio y UseCase de descarga de archivo
  getIt.registerLazySingleton<FileApiClient>(
        () => FileApiClient(getIt<Dio>(instanceName: "noAuth")),
    instanceName: "noAuthClient",
  );

  getIt.registerLazySingleton<FileRepository>(
        () => FileRepositoryImpl(getIt<FileApiClient>(instanceName: "noAuthClient")),
  );

  getIt.registerLazySingleton<DownloadFileUseCase>(
        () => DownloadFileUseCase(getIt<FileRepository>()),
  );

  // Registra el FileBloc, pasando el DownloadFileUseCase
  getIt.registerFactory<FileBloc>(
        () => FileBloc(getIt<DownloadFileUseCase>()),
  );

  // ---------- LUGAR GENERAL ----------
  getIt.registerLazySingleton<LugarGeneralApiClient>(
        () => LugarGeneralApiClient(getIt<Dio>(instanceName: "noAuth")),
    instanceName: "noAuthClient",
  );

  getIt.registerLazySingleton<LugarGeneralRespository>(
        () => LugarGeneralRepositoryImpl(getIt<LugarGeneralApiClient>(instanceName: "noAuthClient")),
  );

  getIt.registerLazySingleton<GetLugaresGeneralUsecase>(
        () => GetLugaresGeneralUsecase(getIt<LugarGeneralRespository>()),
  );

  getIt.registerLazySingleton<BuscarLugaresPorNombreGeneralUsecase>(
        () => BuscarLugaresPorNombreGeneralUsecase(getIt<LugarGeneralRespository>()),
  );

  getIt.registerLazySingleton<GetFamiliasPorLugarGeneralUsecase>(
        () => GetFamiliasPorLugarGeneralUsecase(getIt<LugarGeneralRespository>()),
  );

  // ---------- FAMILIA CATEGORIA GENERAL ----------
  getIt.registerLazySingleton<FamiliaCategoriaGeneralApiClient>(
        () => FamiliaCategoriaGeneralApiClient(getIt<Dio>(instanceName: "noAuth")),
    instanceName: "noAuthClient",
  );

  getIt.registerLazySingleton<FamiliaCategoriaGeneralRepository>(
        () => FamiliaCategoriaGeneralRepositoryImpl(getIt<FamiliaCategoriaGeneralApiClient>(instanceName: "noAuthClient")),
  );

  getIt.registerLazySingleton<ListarRelacionesUsecaseGeneral>(
        () => ListarRelacionesUsecaseGeneral(getIt<FamiliaCategoriaGeneralRepository>()),
  );

  getIt.registerLazySingleton<ObtenerPorIdCategoriaUsecaseGeneral>(
        () => ObtenerPorIdCategoriaUsecaseGeneral(getIt<FamiliaCategoriaGeneralRepository>()),
  );

  getIt.registerLazySingleton<ObtenerPorIdFamiliaUsecaseGeneral>(
        () => ObtenerPorIdFamiliaUsecaseGeneral(getIt<FamiliaCategoriaGeneralRepository>()),
  );

  getIt.registerLazySingleton<GetEmprendimientosPorFamiliaCategoriaUsecaseGeneral>(
        () => GetEmprendimientosPorFamiliaCategoriaUsecaseGeneral(getIt<FamiliaCategoriaGeneralRepository>()),
  );

  // ---------- FAMILIA GENERAL ----------
  getIt.registerLazySingleton<FamiliaGeneralApiClient>(
        () => FamiliaGeneralApiClient(getIt<Dio>(instanceName: "noAuth")),
    instanceName: "noAuthClient",
  );

  getIt.registerLazySingleton<FamiliaGeneralRepository>(
        () => FamiliaGeneralRepositoryImpl(getIt<FamiliaGeneralApiClient>(instanceName: "noAuthClient")),
  );

  getIt.registerLazySingleton<BuscarFamiliasPorNombreUsecaseGeneral>(
        () => BuscarFamiliasPorNombreUsecaseGeneral(getIt<FamiliaGeneralRepository>()),
  );

  getIt.registerLazySingleton<GetFamiliaByIdUsecaseGeneral>(
        () => GetFamiliaByIdUsecaseGeneral(getIt<FamiliaGeneralRepository>()),
  );

  getIt.registerLazySingleton<GetFamiliasUsecaseGeneral>(
        () => GetFamiliasUsecaseGeneral(getIt<FamiliaGeneralRepository>()),
  );

  // ---------- CATEGORIA GENERAL ----------
  getIt.registerLazySingleton<CategoriaGeneralApiClient>(
        () => CategoriaGeneralApiClient(getIt<Dio>(instanceName: "noAuth")),
    instanceName: "noAuthClient",
  );

  getIt.registerLazySingleton<CategoriaGeneralRepository>(
        () => CategoriaGeneralRepositoryImpl(getIt<CategoriaGeneralApiClient>(instanceName: "noAuthClient")),
  );

  getIt.registerLazySingleton<BuscarCategoriasPorNombreUsecaseGeneral>(
        () => BuscarCategoriasPorNombreUsecaseGeneral(getIt<CategoriaGeneralRepository>()),
  );

  getIt.registerLazySingleton<GetCategoriaByIdUsecaseGeneral>(
        () => GetCategoriaByIdUsecaseGeneral(getIt<CategoriaGeneralRepository>()),
  );

  getIt.registerLazySingleton<GetCategoriasUsecaseGeneral>(
        () => GetCategoriasUsecaseGeneral(getIt<CategoriaGeneralRepository>()),
  );

  // ---------- EMPRENDIMIENTO GENERAL ----------
  getIt.registerLazySingleton<EmprendimientoGeneralApiClient>(
        () => EmprendimientoGeneralApiClient(getIt<Dio>(instanceName: "noAuth")),
    instanceName: "noAuthClient",
  );

  getIt.registerLazySingleton<EmprendimientoGeneralRepository>(
        () => EmprendimientoGeneralRepositoryImpl(getIt<EmprendimientoGeneralApiClient>(instanceName: "noAuthClient")),
  );

  getIt.registerLazySingleton<BuscarEmprendimientosPorNombreUseCaseGeneral>(
        () => BuscarEmprendimientosPorNombreUseCaseGeneral(getIt<EmprendimientoGeneralRepository>()),
  );

  getIt.registerLazySingleton<GetEmprendimientoByIdUsecaseGeneral>(
        () => GetEmprendimientoByIdUsecaseGeneral(getIt<EmprendimientoGeneralRepository>()),
  );

  getIt.registerLazySingleton<GetEmprendimientosUsecaseGeneral>(
        () => GetEmprendimientosUsecaseGeneral(getIt<EmprendimientoGeneralRepository>()),
  );

  // ---------- SERVICIO TURISTICO GENERAL ----------
  getIt.registerLazySingleton<ServicioTuristicoGeneralApiClient>(
        () => ServicioTuristicoGeneralApiClient(getIt<Dio>(instanceName: "noAuth")),
    instanceName: "noAuthClient",
  );

  getIt.registerLazySingleton<ServicioTuristicoGeneralRepository>(
        () => ServicioTuristicoGeneralRepositoryImpl(getIt<ServicioTuristicoGeneralApiClient>(instanceName: "noAuthClient")),
  );

  getIt.registerLazySingleton<GetServiciosPorEmprendimientoUseCase>(
        () => GetServiciosPorEmprendimientoUseCase(getIt<ServicioTuristicoGeneralRepository>()),
  );

  // ---------- UBICACION ----------
  getIt.registerLazySingleton<UbicacionGeneralApiClient>(
        () => UbicacionGeneralApiClient(getIt<Dio>(instanceName: "noAuth")),
    instanceName: "noAuthClient",
  );

  getIt.registerLazySingleton<UbicacionRepository>(
        () => UbicacionRepositoryImpl(getIt<UbicacionGeneralApiClient>(instanceName: "noAuthClient")),
  );

  getIt.registerLazySingleton<ObtenerUbicacionesUseCase>(
        () => ObtenerUbicacionesUseCase(getIt<UbicacionRepository>()),
  );
  }