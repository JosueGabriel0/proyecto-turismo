import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/core/services/image_memory_cache_service.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/file/file_admin_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/file/file_admin_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/file/file_admin_state.dart';

class ImagenDesdeBlocWidget extends StatefulWidget {
  final String fileName;
  final BoxFit fit;

  const ImagenDesdeBlocWidget({
    Key? key,
    required this.fileName,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  State<ImagenDesdeBlocWidget> createState() => _ImagenDesdeBlocWidgetState();
}

class _ImagenDesdeBlocWidgetState extends State<ImagenDesdeBlocWidget> {
  Uint8List? imagenBytes;

  @override
  void initState() {
    super.initState();
    final cache = ImageMemoryCacheService();
    final Uint8List? cached = cache.get(widget.fileName);

    if (cached != null) {
      print('✅ Imagen desde cache: ${widget.fileName}');
      imagenBytes = cached;
    } else {
      print('⬇️ Solicitando imagen desde backend: ${widget.fileName}');
      context.read<FileAdminBloc>().add(
        DownloadFileEvent(tipo: 'imagenes', filename: widget.fileName),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cache = ImageMemoryCacheService();

    if (imagenBytes != null) {
      return _buildImage(imagenBytes!);
    }

    return BlocListener<FileAdminBloc, FileAdminState>(
      listenWhen: (_, current) => current is FileDownloadSuccess,
        listener: (context, state) {
          if (state is FileDownloadSuccess) {
            final bytes = Uint8List.fromList(state.bytes); // ✅ correcto
            cache.set(widget.fileName, bytes);
            if (mounted) {
              setState(() {
                imagenBytes = bytes;
              });
            }
          }
        },
        child: imagenBytes != null
          ? _buildImage(imagenBytes!)
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildImage(Uint8List bytes) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.memory(bytes, fit: widget.fit),
    );
  }
}