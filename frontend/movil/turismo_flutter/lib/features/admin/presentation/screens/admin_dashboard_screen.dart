import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/file/file_state.dart';

class AdminDashboardScreen extends StatelessWidget {

  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String fileName = "1746327326372_33.jpg";
    // Dispara la descarga al construir la pantalla
    context.read<FileBloc>().add(DownloadFileEvent(fileName));

    return Scaffold(
      body: Center(
        child: BlocBuilder<FileBloc, FileState>(
          builder: (context, state) {
            if (state is FileDownloading) {
              return const CircularProgressIndicator();
            } else if (state is FileDownloaded) {
              return Image.memory(state.fileData);
            } else if (state is FileDownloadError) {
              return Text('Error al cargar imagen:', style: const TextStyle(color: Colors.red));
            } else {
              return const SizedBox.shrink(); // Estado inicial u otro
            }
          },
        ),
      ),
    );
  }
}
