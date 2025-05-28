import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_state.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_user_response.dart';

class ReservasScreen extends StatefulWidget {
  const ReservasScreen({super.key});

  @override
  State<ReservasScreen> createState() => _ReservasScreenState();
}

class _ReservasScreenState extends State<ReservasScreen> {
  @override
  void initState() {
    super.initState();
    _loadReservas();
  }

  Future<void> _loadReservas() async {
    final tokenService = TokenStorageService();
    final token = await tokenService.getToken();
    final idUsuario = getIdUsuarioFromToken(token);

    if (idUsuario != null) {
      context.read<ReservaBloc>().add(ObtenerReservasPorIdUsuarioEvent(idUsuario));
    }
  }

  void _mostrarDetalle(ReservaUserResponse reserva) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Detalle de Reserva"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Reserva ID: ${reserva.idReserva}"),
              Text("Estado: ${reserva.estado}"),
              Text("Inicio: ${reserva.fechaHoraInicio}"),
              Text("Fin: ${reserva.fechaHoraFin}"),
              Text("Fecha Creación: ${reserva.fechaCreacionReserva}"),
              const Divider(),
              const Text("Detalles:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...reserva.reservaDetalles.map((detalle) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("• ${detalle.descripcion}"),
                    if (detalle.tipoServicio != null) Text("  Tipo: ${detalle.tipoServicio}"),
                    if (detalle.cantidad != null) Text("  Cantidad: ${detalle.cantidad}"),
                    if (detalle.precioUnitario != null) Text("  Precio: S/ ${detalle.precioUnitario}"),
                    if (detalle.total != null) Text("  Total: S/ ${detalle.total}"),
                  ],
                ),
              )),
              Text("Total general: ${reserva.totalGeneral}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ReservaBloc, ReservaState>(
        builder: (context, state) {
          if (state is ReservaLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReservaListLoaded) {
            if (state.reservas.isEmpty) {
              return const Center(child: Text("No hay reservas."));
            }

            return ListView.builder(
              itemCount: state.reservas.length,
              itemBuilder: (_, index) {
                final reserva = state.reservas[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    title: Text("Reserva #${reserva.idReserva}"),
                    subtitle: Text(
                        "Inicio: ${reserva.fechaHoraInicio.toLocal()}\nEstado: ${reserva.estado}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () => _mostrarDetalle(reserva),
                    ),
                  ),
                );
              },
            );
          } else if (state is ReservaError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text("Cargando..."));
        },
      ),
    );
  }
}