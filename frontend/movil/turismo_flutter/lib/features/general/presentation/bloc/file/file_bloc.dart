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
    emit(FileDownloading());
    try {
      final fileData = await _downloadFileUseCase.execute(event.fileName);
      emit(FileDownloaded(fileData));
    } catch (e) {
      emit(FileDownloadError(e.toString()));
    }
  }
}