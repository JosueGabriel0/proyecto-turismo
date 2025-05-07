import 'dart:typed_data';
import 'package:equatable/equatable.dart';

abstract class FileState extends Equatable {
  @override
  List<Object> get props => [];
}

class FileInitial extends FileState {}

class FileDownloading extends FileState {}

class FileDownloaded extends FileState {
  final Uint8List fileData;

  FileDownloaded(this.fileData);

  @override
  List<Object> get props => [fileData];
}

class FileDownloadError extends FileState {
  final String error;

  FileDownloadError(this.error);

  @override
  List<Object> get props => [error];
}