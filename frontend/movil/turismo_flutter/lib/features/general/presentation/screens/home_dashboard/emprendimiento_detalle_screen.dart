import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/emprendimiento/emprendimiento_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/emprendimiento/emprendimiento_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/emprendimiento/emprendimiento_general_state.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/foto_rectangulo_widget.dart';

class EmprendimientoDetalleScreen extends StatefulWidget {
  final Function(int newIndex, {int? id}) onNavigate;
  final int? idEmprendimiento;
  final Function(int newIndex) onNavigateIndex;

  const EmprendimientoDetalleScreen({
    Key? key,
    required this.onNavigate,
    required this.idEmprendimiento,
    required this.onNavigateIndex,
  }) : super(key: key);

  @override
  State<EmprendimientoDetalleScreen> createState() => _EmprendimientoDetalleScreenState();
}

class _EmprendimientoDetalleScreenState extends State<EmprendimientoDetalleScreen> {
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      if (widget.idEmprendimiento != null) {
        print("idEmprendimiento recibido en pantalla: ${widget.idEmprendimiento}");
        context.read<EmprendimientoGeneralBloc>().add(
          GetEmprendimientoByIdGeneralEvent(widget.idEmprendimiento!),
        );
      } else {
        print("⚠️ idEmprendimiento es null");
        // Aquí puedes mostrar un error o navegar hacia atrás
      }
      _isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => widget.onNavigateIndex(3),
        ),
      ),
      body: BlocBuilder<EmprendimientoGeneralBloc, EmprendimientoGeneralState>(
        builder: (context, state) {
          if (state is EmprendimientoLoadingGeneral) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmprendimientoLoadedGeneral) {
            final e = state.emprendimiento;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FotoRectanguloWidget(fileName: e.imagenUrl ?? "", height: 200),
                  const SizedBox(height: 16),
                  Text(e.nombre, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(e.descripcion, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  if (e.latitud != null && e.longitud != null)
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red),
                        const SizedBox(width: 4),
                        Text("Ubicación: ${e.latitud}, ${e.longitud}"),
                      ],
                    ),
                  const SizedBox(height: 16),
                  Text("Creado: ${e.fechaCreacionEmprendimiento}"),
                  if (e.fechaModificacionEmprendimiento != null)
                    Text("Modificado: ${e.fechaModificacionEmprendimiento}"),

                  const SizedBox(height: 32),

                  // 👇 AQUÍ AGREGAS EL BOTÓN
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        widget.onNavigate(5, id: widget.idEmprendimiento); // acción al presionar
                      },
                      icon: const Icon(Icons.event_available, color: Colors.black), // ícono negro
                      label: const Text(
                        "REALIZAR RESERVA",
                        style: TextStyle(color: Colors.black), // texto negro
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        backgroundColor: Color(0xFF5AC7F5),
                        foregroundColor: Colors.black, // en caso quieras definirlo también aquí
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is EmprendimientoErrorGeneral) {
            return Center(child: Text("Error: ${state.message}"));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}