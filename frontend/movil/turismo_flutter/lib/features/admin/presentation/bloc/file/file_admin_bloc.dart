import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/file/download_file_admin_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/file/upload_file_admin_usecase.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/file/file_admin_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/file/file_admin_state.dart';

class FileAdminBloc extends Bloc<FileAdminEvent, FileAdminState> {
  final UploadFileAdminUsecase uploadUsecase;
  final DownloadFileAdminUsecase downloadUsecase;

  FileAdminBloc({
    required this.uploadUsecase,
    required this.downloadUsecase,
  }) : super(FileAdminInitial()) {
    on<UploadFileEvent>(_onUploadFile);
    on<DownloadFileEvent>(_onDownloadFile);
  }

  Future<void> _onUploadFile(
      UploadFileEvent event, Emitter<FileAdminState> emit) async {
    emit(FileAdminLoading());
    try {
      final fileName = await uploadUsecase(
        file: event.file,
        tipo: event.tipo,
      );
      emit(FileUploadSuccess(fileName, event.tipo));
    } catch (e) {
      emit(FileAdminError("Error al subir archivo: $e"));
    }
  }

  Future<void> _onDownloadFile(
      DownloadFileEvent event, Emitter<FileAdminState> emit) async {
    emit(FileAdminLoading());
    try {
      final bytes = await downloadUsecase(
        tipo: event.tipo,
        filename: event.filename,
      );
      emit(FileDownloadSuccess(bytes));
    } catch (e) {
      emit(FileAdminError("Error al descargar archivo: $e"));
    }
  }
}