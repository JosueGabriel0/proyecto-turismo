// video_fullscreen_page.dart
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoFullScreenPage extends StatefulWidget {
  final Uint8List videoBytes;
  final String fileName;

  const VideoFullScreenPage({
    super.key,
    required this.videoBytes,
    required this.fileName,
  });

  @override
  State<VideoFullScreenPage> createState() => _VideoFullScreenPageState();
}

class _VideoFullScreenPageState extends State<VideoFullScreenPage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/${widget.fileName}';
    final file = File(filePath);
    await file.writeAsBytes(widget.videoBytes);

    _controller = VideoPlayerController.file(file);
    await _controller.initialize();
    _controller.setLooping(false);
    await _controller.play();

    // Esperamos hasta estar seguros que está listo
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _isInitialized
            ? Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              child: Icon(
                _controller.value.isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_fill,
                size: 70,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: VideoProgressIndicator(
                _controller,
                allowScrubbing: true,
                colors: VideoProgressColors(
                  playedColor: Colors.red,
                  bufferedColor: Colors.grey,
                  backgroundColor: Colors.white24,
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        )
            : const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}