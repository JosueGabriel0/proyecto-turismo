import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/general/domain/usecases/file/download_file_usecase.dart';
import 'file_event.dart';
import 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final DownloadFileUseCase _downloadFileUseCase;

  FileBloc(this._downloadFileUseCase) : super(FileInitial()) {
    on<DownloadFileEvent>(_onDownloadFile);
  }

  Future<void> _onDownloadFile(
      DownloadFileEvent event,
      Emitter<FileState> emit,
      ) async {
    print('📦 FileBloc: Iniciando descarga de archivo: ${event.fileName}');
    emit(FileDownloading());
    try {
      final fileData = await _downloadFileUseCase.execute(event.fileName);
      print('✅ FileBloc: Archivo descargado correctamente (${event.fileName}), tamaño: ${fileData.length}');
      print('🧪 Primeros bytes del archivo: ${fileData.sublist(0, 20)}');
      emit(FileDownloaded(fileData));
    } catch (e) {
      print('❌ FileBloc: Error al descargar archivo "${event.fileName}": $e');
      emit(FileDownloadError(e.toString()));
    }
  }
}