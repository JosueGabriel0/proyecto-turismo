import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class FileAdminEvent extends Equatable {
  const FileAdminEvent();

  @override
  List<Object?> get props => [];
}

class UploadFileEvent extends FileAdminEvent {
  final File file;
  final String tipo;

  const UploadFileEvent({required this.file, required this.tipo});

  @override
  List<Object?> get props => [file, tipo];
}

class DownloadFileEvent extends FileAdminEvent {
  final String tipo;
  final String filename;

  const DownloadFileEvent({required this.tipo, required this.filename});

  @override
  List<Object?> get props => [tipo, filename];
}