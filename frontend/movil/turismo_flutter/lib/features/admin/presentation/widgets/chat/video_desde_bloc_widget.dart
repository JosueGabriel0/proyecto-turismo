import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turismo_flutter/core/services/image_memory_cache_service.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/chat/video_full_screen_page.dart';
import 'package:video_player/video_player.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/file/file_admin_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/file/file_admin_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/file/file_admin_state.dart';

class VideoDesdeBlocWidget extends StatefulWidget {
  final String fileName;

  const VideoDesdeBlocWidget({Key? key, required this.fileName}) : super(key: key);

  @override
  State<VideoDesdeBlocWidget> createState() => _VideoDesdeBlocWidgetState();
}

class _VideoDesdeBlocWidgetState extends State<VideoDesdeBlocWidget> {
  Uint8List? videoBytes;
  VideoPlayerController? _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  Future<void> _loadVideo() async {
    final cache = ImageMemoryCacheService();

    if (cache.contains(widget.fileName)) {
      videoBytes = cache.get(widget.fileName);
      await _initializeController(videoBytes!);
    } else {
      context.read<FileAdminBloc>().add(
        DownloadFileEvent(tipo: 'videos', filename: widget.fileName),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeController(Uint8List bytes) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/${widget.fileName}';
      final file = File(filePath);

      if (!await file.exists()) {
        await file.writeAsBytes(bytes); // Guardar archivo solo si no existe
      }

      _controller = VideoPlayerController.file(file);
      await _controller!.initialize();
      _controller!.setLooping(false);

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error al inicializar el video: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FileAdminBloc, FileAdminState>(
      listenWhen: (_, state) => state is FileDownloadSuccess,
      listener: (context, state) async {
        if (state is FileDownloadSuccess) {
          videoBytes = Uint8List.fromList(state.bytes);

          // Guardar en caché
          ImageMemoryCacheService().set(widget.fileName, videoBytes!);

          await _initializeController(videoBytes!);
        }
      },
      child: isLoading || _controller == null || !_controller!.value.isInitialized
          ? const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      )
          : AspectRatio(
        aspectRatio: _controller!.value.aspectRatio,
        child: GestureDetector(
          onTap: () {
            if (videoBytes != null && _controller!.value.isInitialized) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VideoFullScreenPage(
                    videoBytes: videoBytes!,
                    fileName: widget.fileName,
                  ),
                ),
              );
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(_controller!),
              if (!_controller!.value.isPlaying)
                const Icon(Icons.play_circle_fill, size: 50, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}