import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_completo_response.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/emprendimiento/emprendimiento_emprendedor_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/emprendimiento/emprendimiento_emprendedor_event.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/emprendimiento/emprendimiento_emprendedor_state.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/reserva/reserva_emprendedor_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/reserva/reserva_emprendedor_event.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/reserva/reserva_emprendedor_state.dart';

class MisReservasScreen extends StatefulWidget {
  const MisReservasScreen({super.key});

  @override
  State<MisReservasScreen> createState() => _MisReservasScreenState();
}

class _MisReservasScreenState extends State<MisReservasScreen> {
  int? _idEmprendimiento;

  @override
  void initState() {
    super.initState();
    _cargarEmprendimientoYReservas();
  }

  final List<String> estadosReserva = ['PENDIENTE', 'CONFIRMADA', 'CANCELADA', 'RECHAZADA'];

  Future<void> _cargarEmprendimientoYReservas() async {
    final tokenService = TokenStorageService();
    final token = await tokenService.getToken();

    if (token != null) {
      final int? idUsuario = getIdUsuarioFromToken(token);
      if (idUsuario != null) {
        // 👉 Pedimos el emprendimiento del usuario
        context.read<EmprendimientoEmprendedorBloc>().add(
          GetEmprendimientoByIdUsuarioEmprendedorEvent(idUsuario),
        );
      } else {
        print("ID de usuario no válido");
      }
    } else {
      print("Token no encontrado");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<EmprendimientoEmprendedorBloc, EmprendimientoEmprendedorState>(
            listener: (context, state) {
              if (state is EmprendimientoEmprendedorLoaded) {
                _idEmprendimiento = state.response.idEmprendimiento;
                context.read<ReservaEmprendedorBloc>().add(
                  ObtenerReservasPorEmprendimientoEvent(_idEmprendimiento!),
                );
              } else if (state is EmprendimientoEmprendedorError) {
                print("Error al cargar emprendimiento: ${state.message}");
              }
            },
          ),
          BlocListener<ReservaEmprendedorBloc, ReservaEmprendedorState>(
            listener: (context, state) {
              if (state is ReservaActualizada && _idEmprendimiento != null) {
                context.read<ReservaEmprendedorBloc>().add(
                  ObtenerReservasPorEmprendimientoEvent(_idEmprendimiento!),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<ReservaEmprendedorBloc, ReservaEmprendedorState>(
          builder: (context, state) {
            if (state is ReservaLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReservasCargadas) {
              final reservas = state.reservas;
              if (reservas.isEmpty) {
                return const Center(child: Text("No hay reservas disponibles."));
              }

              return ListView.builder(
                itemCount: reservas.length,
                itemBuilder: (context, index) {
                  final reserva = reservas[index];
                  return _buildReservaCard(reserva);
                },
              );
            } else if (state is ReservaError) {
              return Center(child: Text(state.mensaje));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildReservaCard(ReservaEmprendedorCompletoResponse reserva) {
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reserva #${reserva.idReserva}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text("Inicio: ${dateFormatter.format(reserva.fechaHoraInicio)}"),
            Text("Fin: ${dateFormatter.format(reserva.fechaHoraFin)}"),
            Text("Total: S/. ${reserva.totalGeneral.toStringAsFixed(2)}"),
            const SizedBox(height: 6),
            Text("Detalles: ${reserva.reservaDetalles.length} ítems"),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Estado:"),
                DropdownButton<String>(
                  value: reserva.estado,
                  items: estadosReserva
                      .map((estado) => DropdownMenuItem(
                    value: estado,
                    child: Text(estado),
                  ))
                      .toList(),
                  onChanged: (nuevoEstado) {
                    if (nuevoEstado != null && nuevoEstado != reserva.estado) {
                      context.read<ReservaEmprendedorBloc>().add(
                        ActualizarEstadoReservaEvent(
                          reserva.idReserva,
                          nuevoEstado,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}