import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/admin_injection.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_dto_user.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_state.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  bool isEditing = false;

  final nombresController = TextEditingController();
  final apellidosController = TextEditingController();
  final direccionController = TextEditingController();
  final telefonoController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getIt<UsuarioUserBloc>().add(GetMyUsuarioUserEvent());
  }

  @override
  void dispose() {
    nombresController.dispose();
    apellidosController.dispose();
    direccionController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsuarioUserBloc>.value(
      value: getIt<UsuarioUserBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Mi Perfil')),
        body: BlocConsumer<UsuarioUserBloc, UsuarioUserState>(
          listener: (context, state) {
            if (state is UsuarioUserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is UsuarioUserProfileLoaded && isEditing) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Perfil actualizado")),
              );
              setState(() => isEditing = false);
            }
          },
          builder: (context, state) {
            if (state is UsuarioUserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UsuarioUserProfileLoaded) {
              final usuario = state.usuario;
              final persona = usuario.persona;

              if (!isEditing) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("👤 Nombre: ${persona?.nombres} ${persona?.apellidos}"),
                      Text("📧 Correo: ${persona?.correoElectronico}"),
                      Text("📱 Teléfono: ${persona?.telefono}"),
                      Text("🏠 Dirección: ${persona?.direccion}"),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            isEditing = true;
                            nombresController.text = persona?.nombres ?? '';
                            apellidosController.text = persona?.apellidos ?? '';
                            direccionController.text = persona?.direccion ?? '';
                            telefonoController.text = persona?.telefono ?? '';
                          });
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("Actualizar"),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        TextFormField(
                          controller: nombresController,
                          decoration: const InputDecoration(labelText: "Nombres"),
                          validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
                        ),
                        TextFormField(
                          controller: apellidosController,
                          decoration: const InputDecoration(labelText: "Apellidos"),
                          validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
                        ),
                        TextFormField(
                          controller: direccionController,
                          decoration: const InputDecoration(labelText: "Dirección"),
                          validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
                        ),
                        TextFormField(
                          controller: telefonoController,
                          decoration: const InputDecoration(labelText: "Teléfono"),
                          keyboardType: TextInputType.phone,
                          validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;

                            final dto = UsuarioDtoUser(
                              username: usuario.username ?? '',
                              password: usuario.password,
                              nombres: nombresController.text,
                              apellidos: apellidosController.text,
                              tipoDocumento: persona?.tipoDocumento ?? 'DNI',
                              numeroDocumento: persona?.numeroDocumento ?? '',
                              telefono: telefonoController.text,
                              direccion: direccionController.text,
                              correoElectronico: persona?.correoElectronico ?? '',
                              fechaNacimiento: persona?.fechaNacimiento ?? '2000-01-01',
                            );

                            context.read<UsuarioUserBloc>().add(
                              PutUsuarioUserEvent(
                                usuario.idUsuario,
                                dto,
                                null,
                              ),
                            );
                          },
                          icon: const Icon(Icons.save),
                          label: const Text("Guardar Cambios"),
                        ),
                        TextButton(
                          onPressed: () => setState(() => isEditing = false),
                          child: const Text("Cancelar"),
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else if (state is UsuarioUserError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text("No se encontró información del perfil."));
            }
          },
        ),
      ),
    );
  }
}