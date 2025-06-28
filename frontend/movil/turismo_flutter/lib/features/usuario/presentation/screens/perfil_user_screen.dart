import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/perfil/perfil_admin_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/perfil/perfil_admin_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/perfil/perfil_admin_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_state.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/formulario_actualizar_usuario.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_state.dart';
import 'package:turismo_flutter/features/usuario/presentation/screens/formulario_actualizar_user.dart';

class PerfilUserScreen extends StatefulWidget {
  const PerfilUserScreen({super.key});

  @override
  State<PerfilUserScreen> createState() => _PerfilUserScreenState();
}

class _PerfilUserScreenState extends State<PerfilUserScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsuarioUserBloc>().add(GetMyUsuarioUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsuarioUserBloc, UsuarioUserState>(
        buildWhen: (previous, current) =>
        current is UsuarioUserLoading  ||
            current is UsuarioUserProfileLoaded  ||
            current is UsuarioUserError,
        builder: (context, state) {
          print('[PerfilAdminScreen] Estado actual: $state');
          if (state is UsuarioUserLoading) {
            print('[PerfilAdminScreen] Mostrando indicador de carga...');
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsuarioUserProfileLoaded) {
            print('[PerfilAdminScreen] Usuario cargado: ${state.usuario}');
            final UsuarioUserResponse usuario = state.usuario;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // SECCIÓN SUPERIOR AZUL
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          decoration: const BoxDecoration(
                            color: Color(0xFF3A506B),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(32),
                            ),
                          ),
                          child: Column(
                            children: [
                              FotoWidget(
                                fileName: usuario.persona?.fotoPerfil ?? '',
                                size: 90,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                '${usuario.persona?.nombres ?? ''} ${usuario.persona?.apellidos ?? ''}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                usuario.persona?.correoElectronico ?? '',
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // INFORMACIÓN DEL PERFIL
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _buildField('Nombres y apellidos:', '${usuario.persona?.nombres} ${usuario.persona?.apellidos}', Icons.person),
                              _buildField('Fecha de nacimiento:', usuario.persona?.fechaNacimiento ?? '', Icons.cake),
                              _buildField('Documento:', '${usuario.persona?.tipoDocumento ?? ''} - ${usuario.persona?.numeroDocumento ?? ''}', Icons.badge),
                              _buildField('Dirección:', usuario.persona?.direccion ?? '', Icons.home),
                              _buildField('Teléfono:', usuario.persona?.telefono ?? '', Icons.phone),
                              _buildField('Username:', usuario.username ?? '', Icons.account_circle),
                              _buildField('Rol:', usuario.rol?.nombre ?? '', Icons.security),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // BOTÓN AL FINAL
                // SECCIÓN ACTUALIZAR CON FONDO blueGrey
                Container(
                  width: double.infinity,
                  color: Color(0xFF3A506B).withOpacity(0.2),
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text('Actualizar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3A506B), // color del botón
                      foregroundColor: Colors.white,    // color del texto/icono
                    ),
                      onPressed: () async {
                        final result = await showModalBottomSheet<bool>(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          builder: (context) => Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: FormularioActualizarUser(usuario: usuario),
                          ),
                        );
                      }
                  ),
                ),
              ],
            );
          } else if (state is UsuarioUserError) {
            print('[PerfilAdminScreen] Error: ${state.message}');
            return Center(child: Text(state.message));
          } else {
            print('[PerfilAdminScreen] Estado no reconocido o sin datos');
            return const Center(child: Text('No se encontró información del usuario.'));
          }
        },
      ),
    );
  }

  Widget _buildField(String label, String value, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}