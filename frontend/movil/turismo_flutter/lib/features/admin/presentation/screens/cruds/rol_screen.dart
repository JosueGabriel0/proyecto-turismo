import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_dto.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_state.dart';

class RolScreen extends StatelessWidget {
  const RolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RolBloc, RolState>(
        builder: (context, state) {
          if (state is RolLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RolErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is RolLoadedState) {
            return ListView.builder(
              itemCount: state.roles.length,
              itemBuilder: (context, index) {
                final role = state.roles[index];
                return Dismissible(
                  key: Key(role.idRol.toString()), // Clave única para el item
                  direction: DismissDirection.endToStart, // Solo permitir deslizar de derecha a izquierda
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    // Confirmar antes de eliminar
                    return await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Eliminar Rol'),
                          content: const Text('¿Estás seguro de que deseas eliminar este rol?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Eliminar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    context.read<RolBloc>().add(DeleteRolEvent(idRol: role.idRol));
                  },
                  child: ListTile(
                    title: Text(role.nombre),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _showUpdateDialog(context, role);
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No hay roles disponibles'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Crear un nuevo rol
  void _showCreateDialog(BuildContext context) {
    final _nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Crear Rol'),
          content: TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nombre del rol'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final rolDto = RolDto(nombre: _nameController.text);
                context.read<RolBloc>().add(CreateRolEvent(rolDto: rolDto));
                Navigator.of(context).pop();
              },
              child: const Text('Crear'),
            ),
          ],
        );
      },
    );
  }

  // Actualizar un rol
  void _showUpdateDialog(BuildContext context, rol) {
    final _nameController = TextEditingController(text: rol.nombre);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Actualizar Rol'),
          content: TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nombre del rol'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final rolDto = RolDto(nombre: _nameController.text);
                context.read<RolBloc>().add(UpdateRolEvent(idRol: rol.idRol, rolDto: rolDto));
                Navigator.of(context).pop();
              },
              child: const Text('Actualizar'),
            ),
          ],
        );
      },
    );
  }

  // Eliminar un rol
  void _deleteRol(BuildContext context, int idRol) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Rol'),
          content: const Text('¿Estás seguro de que deseas eliminar este rol?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                context.read<RolBloc>().add(DeleteRolEvent(idRol: idRol));
                Navigator.of(context).pop();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}