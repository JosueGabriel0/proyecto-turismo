import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/admin_injection.dart';
import 'package:turismo_flutter/features/general/domain/usecases/file/download_file_usecase.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_state.dart';

class ImagenDescargadaWidget extends StatefulWidget {
  final String fileName;
  final double width;
  final double height;
  final BoxFit fit;

  const ImagenDescargadaWidget({
    Key? key,
    required this.fileName,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  _ImagenDescargadaWidgetState createState() => _ImagenDescargadaWidgetState();
}

class _ImagenDescargadaWidgetState extends State<ImagenDescargadaWidget> {
  late Future<Uint8List> _imageFuture;
  final DownloadFileUseCase _downloadFileUseCase = getIt<DownloadFileUseCase>();

  @override
  void initState() {
    super.initState();
    _imageFuture = _downloadFileUseCase.execute(widget.fileName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _imageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: const Icon(Icons.error),
          );
        } else if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          );
        } else {
          return SizedBox(width: widget.width, height: widget.height);
        }
      },
    );
  }
}