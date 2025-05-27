import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_dto.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_state.dart';

class ReservaScreen extends StatefulWidget {
  final int? idEmprendimiento;
  const ReservaScreen({super.key, required this.idEmprendimiento});

  @override
  State<ReservaScreen> createState() => _ReservaScreenState();
}

class _ReservaScreenState extends State<ReservaScreen> {
  UsuarioUserResponse? _usuario;
  bool _wasUpdated = false;

  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _tipoDocumentoController = TextEditingController();
  final TextEditingController _numeroDocumentoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UsuarioUserBloc>().add(GetMyUsuarioUserEvent());
  }

  @override
  void dispose() {
    _nombresController.dispose();
    _tipoDocumentoController.dispose();
    _numeroDocumentoController.dispose();
    super.dispose();
  }

  void _actualizarUsuario() {
    setState(() {
      _wasUpdated = true;
    });

    if (_usuario == null) return;

    // Crear UsuarioUserDto con datos del formulario y otros campos actuales para no perder info
    final usuarioDto = UsuarioUserDto(
      username: _usuario!.username ?? '',
      password: null,
      estadoCuenta: _usuario!.estado ?? '',
      nombreRol: _usuario!.rol?.nombre ?? '',
      nombres: _nombresController.text,
      apellidos: _usuario!.persona?.apellidos ?? '',
      tipoDocumento: _tipoDocumentoController.text,
      numeroDocumento: _numeroDocumentoController.text,
      telefono: _usuario!.persona?.telefono ?? '',
      direccion: _usuario!.persona?.direccion ?? '',
      correoElectronico: _usuario!.persona?.correoElectronico ?? '',
      fechaNacimiento: _usuario!.persona?.fechaNacimiento ?? '',
    );

    context.read<UsuarioUserBloc>().add(
      PutUsuarioUserEvent(
        _usuario!.idUsuario,
        usuarioDto,
        null
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _wasUpdated = false; // Reiniciamos la bandera
            }
          }

          if (state is UsuarioUserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is UsuarioUserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_usuario == null) {
            return const Center(child: Text('Cargando usuario...'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: _usuario!.persona?.fotoPerfil != null &&
                      _usuario!.persona!.fotoPerfil!.isNotEmpty
                      ? FotoWidget(fileName: _usuario!.persona!.fotoPerfil!, size: 100)
                      : const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Colors.blueGrey),
                  ),
                ),
                const SizedBox(height: 30),

                // Sección: Datos Personales
                const Text(
                  'Datos Personales',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nombresController,
                  decoration: const InputDecoration(
                    labelText: 'Nombres',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _tipoDocumentoController,
                  decoration: const InputDecoration(
                    labelText: 'Tipo de Documento',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _numeroDocumentoController,
                  decoration: const InputDecoration(
                    labelText: 'Número de Documento',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 30),

                // Sección: Datos de Reserva
                const Text(
                  'Datos de Reserva',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Aquí puedes agregar más campos relacionados a la reserva:
                // Ejemplo:
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Fecha de reserva',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Número de personas',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _actualizarUsuario,
                    child: const Text('Actualizar'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}