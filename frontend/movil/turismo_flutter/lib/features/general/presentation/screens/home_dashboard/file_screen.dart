import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileScreen extends StatelessWidget {
  final File pdfFile;

  const FileScreen({
    super.key,
    required this.pdfFile,
  });

  Future<void> _downloadFile(BuildContext context) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de almacenamiento denegado')),
      );
      return;
    }

    final docsDir = Platform.isAndroid
        ? Directory('/storage/emulated/0/Documents')
        : await getApplicationDocumentsDirectory();

    if (!await docsDir.exists()) {
      await docsDir.create(recursive: true);
    }

    final targetPath = '${docsDir.path}/${pdfFile.path.split('/').last}';
    final newFile = await pdfFile.copy(targetPath);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Archivo descargado en: ${newFile.path}')),
    );
  }

  Future<void> _openFile(BuildContext context) async {
    final result = await OpenFile.open(pdfFile.path);
    if (result.type == ResultType.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el archivo PDF')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileName = pdfFile.path.split('/').last;

    return Scaffold(
      appBar: AppBar(title: const Text('Comprobante de Reserva')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            fileName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 4),
                  borderRadius: BorderRadius.circular(5),
                ),
                clipBehavior: Clip.antiAlias,
                child: PDFView(
                  filePath: pdfFile.path,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: false,
                  pageFling: true,
                  onError: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al cargar el PDF: $error')),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _downloadFile(context),
            icon: const Icon(Icons.download),
            label: const Text('Descargar'),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              context.go("/home/reserva");
            },
            icon: const Icon(Icons.arrow_forward, color: Colors.white,),
            label: const Text('Continuar', style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0AA3EF),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}