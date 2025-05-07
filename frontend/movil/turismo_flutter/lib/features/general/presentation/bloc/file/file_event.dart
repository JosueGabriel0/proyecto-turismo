import 'package:equatable/equatable.dart';

abstract class FileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DownloadFileEvent extends FileEvent {
  final String fileName;

  DownloadFileEvent(this.fileName);

  @override
  List<Object> get props => [fileName];
}