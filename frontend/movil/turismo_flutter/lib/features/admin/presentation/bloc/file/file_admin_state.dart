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

  const FileUploadSuccess(this.fileName);

  @override
  List<Object?> get props => [fileName];
}

class FileDownloadSuccess extends FileAdminState {
  final List<int> bytes;

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