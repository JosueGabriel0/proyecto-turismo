import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/servicio_turistico/servicio_turistico_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/servicio_turistico/servicio_turistico_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/servicio_turistico/servicio_turistico_general_state.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home_dashboard/file_screen.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_detalle_dto.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_dto.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_dto_user.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/reserva/reserva_state.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class ReservaScreen extends StatefulWidget {
  final int? idEmprendimiento;
  final Function(int newIndex) onNavigateIndex;
  final Function(int newIndex) onNavigateIndexBottomNav;
  const ReservaScreen({super.key, required this.idEmprendimiento, required this.onNavigateIndex, required this.onNavigateIndexBottomNav});

  @override
  State<ReservaScreen> createState() => _ReservaScreenState();
}

class _ReservaScreenState extends State<ReservaScreen> {
  UsuarioUserResponse? _usuario;
  bool _wasUpdated = false;

  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _tipoDocumentoController = TextEditingController();
  final TextEditingController _numeroDocumentoController = TextEditingController();

  final Map<int, int> _cantidadesSeleccionadas = {};
  final Map<int, String> _observacionesSeleccionadas = {};
  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  int idReservaCreada = 0;

  @override
  void initState() {
    super.initState();
    context.read<UsuarioUserBloc>().add(GetMyUsuarioUserEvent());

    if (widget.idEmprendimiento != null) {
      context.read<ServicioTuristicoGeneralBloc>().add(
        GetServiciosPorEmprendimientoEvent(widget.idEmprendimiento!),
      );
    }
  }

  @override
  void dispose() {
    _nombresController.dispose();
    _tipoDocumentoController.dispose();
    _numeroDocumentoController.dispose();
    super.dispose();
  }

  Future<File> generarPdfReserva(String mensaje, String fileName) async {
    final pdf = pw.Document();

    // Dividir el mensaje en secciones
    final lines = mensaje.split('\n').where((line) => line.trim().isNotEmpty).toList();

    // Extraer secciones específicas (esto depende de cómo construyes el mensaje)
    final fechaLinea = lines.firstWhere((line) => line.contains('Fechas de la reserva:'), orElse: () => '');
    final datosClienteIndex = lines.indexWhere((line) => line.contains('Datos del cliente:'));
    final serviciosIndex = lines.indexWhere((line) => line.contains('Servicios reservados:'));
    final totalLinea = lines.firstWhere((line) => line.contains('Total general'), orElse: () => '');

    final datosCliente = lines.sublist(datosClienteIndex + 1, serviciosIndex);
    final servicios = lines.sublist(serviciosIndex + 1, lines.indexWhere((l) => l.contains('Total general')));

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Center(
            child: pw.Text('Comprobante de Reserva', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 16),

          // Fecha
          if (fechaLinea.isNotEmpty)
            pw.Text(fechaLinea, style: pw.TextStyle(fontSize: 14)),

          pw.SizedBox(height: 12),

          // Datos del cliente
          pw.Text('Datos del Cliente:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16)),
          pw.SizedBox(height: 6),
          ...datosCliente.map((line) => pw.Text(line.trim(), style: pw.TextStyle(fontSize: 12))),
          pw.SizedBox(height: 12),

          // Servicios
          pw.Text('Servicios Reservados:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16)),
          pw.SizedBox(height: 8),
          ..._buildServiciosTable(servicios),

          pw.SizedBox(height: 12),

          // Total
          pw.Text(totalLinea, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
          pw.SizedBox(height: 20),

          pw.Text('Gracias por su atención. Quedo atento(a) a la confirmación.', style: pw.TextStyle(fontSize: 12)),
        ],
      ),
    );

    final outputDir = await getTemporaryDirectory();
    final file = File("${outputDir.path}/$fileName.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  List<pw.Widget> _buildServiciosTable(List<String> servicios) {
    List<pw.Widget> widgets = [];

    for (var s in servicios) {
      if (s.trim().startsWith('🔹')) {
        widgets.add(pw.Divider());
        widgets.add(pw.Text(s.trim(), style: pw.TextStyle(fontWeight: pw.FontWeight.bold)));
      } else if (s.contains(':')) {
        final parts = s.split(':');
        final key = parts[0].replaceAll('•', '').trim();
        final value = parts.sublist(1).join(':').trim();
        widgets.add(pw.Row(
          children: [
            pw.Expanded(flex: 2, child: pw.Text('$key:', style: pw.TextStyle(fontSize: 11))),
            pw.Expanded(flex: 3, child: pw.Text(value, style: pw.TextStyle(fontSize: 11))),
          ],
        ));
      }
    }

    return widgets;
  }

  Future<Directory?> getDocumentsFolder() async {
    if (Platform.isAndroid) {
      // Ruta típica de la carpeta Documentos
      final directory = Directory('/storage/emulated/0/Documents');
      if (await directory.exists()) {
        return directory;
      } else {
        // Si no existe, crea la carpeta Documentos
        await directory.create(recursive: true);
        return directory;
      }
    } else if (Platform.isIOS) {
      // En iOS no existe la carpeta Documentos accesible igual, usa getApplicationDocumentsDirectory
      return await getApplicationDocumentsDirectory();
    }
    return null;
  }

  Future<void> guardarPdfEnDocumentos(File pdfFile, String nuevoNombre) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final docsDir = await getDocumentsFolder();
      if (docsDir != null) {
        final nuevoArchivo = File('${docsDir.path}/$nuevoNombre.pdf');
        await pdfFile.copy(nuevoArchivo.path);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF guardado en Documentos: ${nuevoArchivo.path}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo acceder a la carpeta Documentos')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de almacenamiento denegado')),
      );
    }
  }


  Future<void> enviarMensajeWhatsApp(String numero, String mensaje) async {
    final uri = Uri.parse("https://wa.me/$numero?text=${Uri.encodeComponent(mensaje)}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir WhatsApp';
    }
  }

  void _actualizarUsuario() {
    setState(() => _wasUpdated = true);
    if (_usuario == null) return;

    final usuarioDto = UsuarioDtoUser(
      username: _usuario!.username ?? '',
      password: null,
      nombres: _nombresController.text,
      apellidos: _usuario!.persona?.apellidos ?? '',
      tipoDocumento: _tipoDocumentoController.text,
      numeroDocumento: _numeroDocumentoController.text,
      telefono: _usuario!.persona?.telefono ?? '',
      direccion: _usuario!.persona?.direccion ?? '',
      correoElectronico: _usuario!.persona?.correoElectronico ?? '',
      fechaNacimiento: _usuario!.persona?.fechaNacimiento ?? '',
    );

    context.read<UsuarioUserBloc>().add(PutUsuarioUserEvent(usuarioDto, null));
  }

  void _crearReserva() async {
    if (_fechaInicio == null || _fechaFin == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona fechas válidas')),
      );
      return;
    }

    final detalles = _cantidadesSeleccionadas.entries
        .where((entry) => entry.value > 0)
        .map((entry) => ReservaDetalleDto(
      idServicioTuristico: entry.key,
      cantidad: entry.value,
      observaciones: _observacionesSeleccionadas[entry.key] ?? '',
    ))
        .toList();

    if (detalles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona al menos un servicio con cantidad')),
      );
      return;
    }

    final reserva = ReservaDto(
      idEmprendimiento: widget.idEmprendimiento!,
      fechaHoraInicio: _fechaInicio!,
      fechaHoraFin: _fechaFin!,
      detalles: detalles,
    );

    context.read<ReservaBloc>().add(CrearReservaEvent(reserva));
  }

  Future<void> _seleccionarFecha(BuildContext context, bool esInicio) async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (fecha != null) {
      final hora = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (hora != null) {
        final fechaConHora = DateTime(
          fecha.year,
          fecha.month,
          fecha.day,
          hora.hour,
          hora.minute,
        );

        setState(() {
          if (esInicio) {
            _fechaInicio = fechaConHora;
          } else {
            _fechaFin = fechaConHora;
          }
        });
      }
    }
  }

  String formatFecha(DateTime fecha) {
    final formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(fecha);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => widget.onNavigateIndex(4),
        ),
      ),
      body: BlocConsumer<UsuarioUserBloc, UsuarioUserState>(
        listener: (context, state) {
          if (state is UsuarioUserProfileLoaded) {
            setState(() {
              _usuario = state.usuario;
              _nombresController.text = _usuario?.persona?.nombres ?? '';
              _tipoDocumentoController.text = _usuario?.persona?.tipoDocumento ?? '';
              _numeroDocumentoController.text = _usuario?.persona?.numeroDocumento ?? '';
            });

            if (_wasUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Usuario actualizado correctamente')),
              );
              _wasUpdated = false;
            }
          }

          if (state is UsuarioUserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, usuarioState) {
          return BlocBuilder<ServicioTuristicoGeneralBloc, ServicioTuristicoGeneralState>(
            builder: (context, servicioState) {
              if (usuarioState is UsuarioUserLoading || servicioState is ServicioTuristicoGeneralLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_usuario == null) {
                return const Center(child: Text('Cargando usuario...'));
              }

              final servicios = servicioState is ServicioTuristicoGeneralLoaded ? servicioState.servicios : [];

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Foto
                    Center(
                      child: _usuario!.persona?.fotoPerfil != null && _usuario!.persona!.fotoPerfil!.isNotEmpty
                          ? FotoWidget(fileName: _usuario!.persona!.fotoPerfil!, size: 100)
                          : const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 50, color: Colors.blueGrey),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Datos personales
                    TextFormField(
                      controller: _nombresController,
                      decoration: const InputDecoration(labelText: 'Nombres'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _tipoDocumentoController,
                      decoration: const InputDecoration(labelText: 'Tipo de Documento'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _numeroDocumentoController,
                      decoration: const InputDecoration(labelText: 'Número de Documento'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _actualizarUsuario,
                      child: const Text('Actualizar'),
                    ),
                    const SizedBox(height: 30),

                    // Servicios turísticos
                    const Text('Selecciona servicios y cantidades:', style: TextStyle(fontSize: 16)),
                    ...servicios.map((servicio) {
                      final id = servicio.idServicio;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(servicio.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text('Precio: ${servicio.precioUnitario ?? 'N/A'}'),
                              SizedBox(height: 10,),
                              // Aquí agregamos la imagen
                              FotoWidget(
                                fileName: servicio.imagenUrl ?? '', // o el nombre correcto del campo
                                size: 80,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(labelText: 'Cantidad'),
                                onChanged: (value) {
                                  setState(() {
                                    _cantidadesSeleccionadas[id] = int.tryParse(value) ?? 0;
                                  });
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(labelText: 'Observaciones'),
                                onChanged: (value) {
                                  setState(() {
                                    _observacionesSeleccionadas[id] = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),

                    // Fechas
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _seleccionarFecha(context, true),
                            child: Text(_fechaInicio != null
                                ? 'Inicio: ${formatFecha(_fechaInicio!)}'
                                : 'Seleccionar inicio'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _seleccionarFecha(context, false),
                            child: Text(_fechaFin != null
                                ? 'Fin: ${formatFecha(_fechaFin!)}'
                                : 'Seleccionar fin'),
                          ),
                        ),
                      ],
                    ),

                    if (_fechaInicio != null && _fechaFin != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        'Reserva desde ${formatFecha(_fechaInicio!)} hasta ${formatFecha(_fechaFin!)}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],


                    const SizedBox(height: 20),

                    // Confirmar reserva
                    BlocConsumer<ReservaBloc, ReservaState>(
              listener: (context, state) async {
              if (state is ReservaCreada) {
              idReservaCreada = state.reserva.idReserva;

              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Reserva creada exitosamente. ID: $idReservaCreada')),
              );

              // Paso 1: Obtener la reserva completa (detalles)
              context.read<ReservaBloc>().add(ObtenerReservaPorIdEvent(idReservaCreada));

              } else if (state is ReservaLoaded) {
                final reserva = state.reserva;

                final obtenerTelefonoUseCase = context.read<ReservaBloc>().obtenerTelefonoUseCase;
                final numeroTelefonoEmprendedor = await obtenerTelefonoUseCase.call(widget.idEmprendimiento!);

                String mensaje = '''
✨ *¡Hola! Me gustaría confirmar mi reserva.* ✨

📅 *Fechas de la reserva:*
Desde *${formatFecha(_fechaInicio!)}* hasta *${formatFecha(_fechaFin!)}*

👤 *Datos del cliente:*
• *Nombre:* ${_nombresController.text}
• *Tipo de Documento:* ${_tipoDocumentoController.text}
• *Número de Documento:* ${_numeroDocumentoController.text}

🧾 *Servicios reservados:*
${reserva.reservaDetalles.map((d) => '''
========================
🔹 *${d.descripcion ?? d.tipoServicio ?? 'Servicio sin nombre'}*
• Cantidad: ${d.cantidad ?? '-'}
${d.tipoServicio != null ? '• Tipo: ${d.tipoServicio}' : ''}
${d.precioUnitario != null ? '• Precio unitario: S/${d.precioUnitario!.toStringAsFixed(2)}' : ''}
${d.total != null ? '• Total: S/${d.total!.toStringAsFixed(2)}' : ''}
${d.observaciones != null && d.observaciones!.isNotEmpty ? '• Observaciones: ${d.observaciones}' : ''}
''').join('')}

💰 *Total general de la reserva: S/${reserva.totalGeneral}*

✅ *Gracias por su atención. Quedo atento(a) a la confirmación.*
''';

                // ✅ Generar PDF
                final pdfFile = await generarPdfReserva(mensaje, "reserva_$idReservaCreada");

                // ✅ Compartir PDF con el mensaje
                await enviarMensajeWhatsApp(numeroTelefonoEmprendedor, mensaje);

                // ✅ Redirigir
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FileScreen(
                      pdfFile: pdfFile,
                    ),
                  ),
                );
              }
              else if (state is ReservaError) {
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
              );
              }
              }
,
              builder: (context, state) {
                        return ElevatedButton(
                          onPressed: _crearReserva,
                          child: const Text('Confirmar Reserva'),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}