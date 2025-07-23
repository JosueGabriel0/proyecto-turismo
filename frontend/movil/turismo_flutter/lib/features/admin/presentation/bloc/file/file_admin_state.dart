import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class FileAdminState extends Equatable {
  const FileAdminState();

  @override
  List<Object?> get props => [];
}

class FileAdminInitial extends FileAdminState {}

class FileAdminLoading extends FileAdminState {}

class FileUploadSuccess extends FileAdminState {
  final String fileName;
  final String tipoArchivo;

  const FileUploadSuccess(this.fileName, this.tipoArchivo);

  @override
  List<Object?> get props => [fileName, tipoArchivo];
}

class FileDownloadSuccess extends FileAdminState {
  final Uint8List bytes;

  const FileDownloadSuccess(this.bytes);

  @override
  List<Object?> get props => [bytes];
}

class FileAdminError extends FileAdminState {
  final String message;

  const FileAdminError(this.message);

  @override
  List<Object?> get props => [message];
}