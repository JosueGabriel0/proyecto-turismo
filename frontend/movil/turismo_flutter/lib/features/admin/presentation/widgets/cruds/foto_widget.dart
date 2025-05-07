import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:turismo_flutter/features/general/domain/usecases/file/download_file_usecase.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_state.dart';

class FotoWidget extends StatelessWidget {
  final String fileName; // Ej: "foto_5.jpg"
  final double size;

  const FotoWidget({
    Key? key,
    required this.fileName,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FileBloc>(
      create: (context) => FileBloc(GetIt.instance<DownloadFileUseCase>())
        ..add(DownloadFileEvent(fileName)),
      child: BlocBuilder<FileBloc, FileState>(
        builder: (context, state) {
          if (state is FileDownloaded) {
            return CircleAvatar(
              radius: size / 2,
              backgroundImage: MemoryImage(state.fileData),
            );
          } else if (state is FileDownloading) {
            return CircleAvatar(
              radius: size / 2,
              child: const CircularProgressIndicator(strokeWidth: 2),
            );
          } else {
            return CircleAvatar(
              radius: size / 2,
              child: const Icon(Icons.person),
            );
          }
        },
      ),
    );
  }
}