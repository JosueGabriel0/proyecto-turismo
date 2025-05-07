import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/file_api_client.dart';
import 'package:turismo_flutter/features/general/data/repositories/file_repository_impl.dart';
import 'package:turismo_flutter/features/general/domain/repositories/file_repository.dart';
import 'package:turismo_flutter/features/general/domain/usecases/file/download_file_usecase.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_bloc.dart';

final getIt = GetIt.instance;

void injectGeneralDependencies() {
  // ---------- FILE DOWNLOAD ----------
  // Registra el FileApiClient, Repositorio y UseCase de descarga de archivo
  getIt.registerLazySingleton<FileApiClient>(
        () => FileApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<FileRepository>(
        () => FileRepositoryImpl(getIt<FileApiClient>()),
  );

  getIt.registerLazySingleton<DownloadFileUseCase>(
        () => DownloadFileUseCase(getIt<FileRepository>()),
  );

  // Registra el FileBloc, pasando el DownloadFileUseCase
  getIt.registerFactory<FileBloc>(
        () => FileBloc(getIt<DownloadFileUseCase>()),
  );
}