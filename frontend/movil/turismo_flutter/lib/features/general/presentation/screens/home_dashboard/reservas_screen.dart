import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home_dashboard/file_screen.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_state.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_user_response.dart';
import 'package:pdf/widgets.dart' as pw;

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

  Future<File> generarPdfDesdeReserva(ReservaUserResponse reserva) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Center(
            child: pw.Text('Comprobante de Reserva',
                style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 16),

          // Fechas
          pw.Text('Fechas de la reserva:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text('Inicio: ${reserva.fechaHoraInicio}'),
          pw.Text('Fin: ${reserva.fechaHoraFin}'),
          pw.SizedBox(height: 12),

          // Datos del cliente (ejemplo con ID)
          pw.Text('Datos del Cliente:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16)),
          pw.SizedBox(height: 6),
          pw.Text('ID Usuario: ${reserva.idUsuario}', style: pw.TextStyle(fontSize: 12)),
          pw.SizedBox(height: 12),

          // Servicios
          pw.Text('Servicios Reservados:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16)),
          pw.SizedBox(height: 8),
          ...reserva.reservaDetalles.map((detalle) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Divider(),
              pw.Text('🔹 ${detalle.descripcion}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              if (detalle.tipoServicio != null)
                pw.Text('Tipo: ${detalle.tipoServicio}', style: pw.TextStyle(fontSize: 11)),
              if (detalle.cantidad != null)
                pw.Text('Cantidad: ${detalle.cantidad}', style: pw.TextStyle(fontSize: 11)),
              if (detalle.precioUnitario != null)
                pw.Text('Precio Unitario: S/ ${detalle.precioUnitario}',
                    style: pw.TextStyle(fontSize: 11)),
              if (detalle.total != null)
                pw.Text('Total: S/ ${detalle.total}', style: pw.TextStyle(fontSize: 11)),
            ],
          )),

          pw.SizedBox(height: 12),
          pw.Text('Total general: S/ ${reserva.totalGeneral}',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
          pw.SizedBox(height: 20),

          pw.Text('Gracias por su atención. Quedo atento(a) a la confirmación.',
              style: pw.TextStyle(fontSize: 12)),
        ],
      ),
    );

    final outputDir = await getTemporaryDirectory();
    final file = File("${outputDir.path}/reserva_${reserva.idReserva}.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.picture_as_pdf, color: Colors.red,),
                          onPressed: () async {
                            final pdfFile = await generarPdfDesdeReserva(reserva);
                            showDialog(
                              context: context,
                              builder: (_) => FileScreen(pdfFile: pdfFile),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.info_outline, color: Colors.blue,),
                          onPressed: () => _mostrarDetalle(reserva),
                        ),
                      ],
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