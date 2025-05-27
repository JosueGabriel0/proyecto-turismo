import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:turismo_flutter/features/general/domain/usecases/file/download_file_usecase.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_state.dart';

class FotoRectanguloWidget extends StatelessWidget {
  final String fileName;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;

  const FotoRectanguloWidget({
    Key? key,
    required this.fileName,
    this.width = double.infinity,
    this.height = 130,
    this.fit = BoxFit.cover,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FileBloc>(
      create: (context) => FileBloc(GetIt.I<DownloadFileUseCase>())
        ..add(DownloadFileEvent(fileName)),
      child: BlocBuilder<FileBloc, FileState>(
        builder: (context, state) {
          if (state is FileDownloaded) {
            return ClipRRect(
              borderRadius: borderRadius,
              child: Image.memory(
                state.fileData,
                width: width,
                height: height,
                fit: fit,
              ),
            );
          } else if (state is FileDownloading) {
            return SizedBox(
              width: width,
              height: height,
              child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          } else {
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: borderRadius,
              ),
              child: const Icon(Icons.broken_image),
            );
          }
        },
      ),
    );
  }
}