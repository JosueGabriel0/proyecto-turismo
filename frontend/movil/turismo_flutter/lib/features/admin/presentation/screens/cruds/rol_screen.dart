import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_dto.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_state.dart';

class RolScreen extends StatefulWidget {
  const RolScreen({super.key});

  @override
  State<RolScreen> createState() => _RolScreenState();
}

class _RolScreenState extends State<RolScreen> {
  final TextEditingController _searchController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<RolBloc>().add(GetRolesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<RolBloc, RolState>(
          builder: (context, state) {
            if (state is RolLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is RolErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            }
            if (state is RolLoadedState) {
              return Column(
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      context
                          .read<RolBloc>()
                          .add(BuscarRolPorNombreEvent(value));
                    },
                    decoration: const InputDecoration(
                      labelText: 'Buscar rol...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.roles.length,
                      itemBuilder: (context, index) {
                        final role = state.roles[index];
                        return Dismissible(
                          key: Key(role.idRol.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          confirmDismiss: (direction) async {
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
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                            elevation: 3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: ListTile(
                              title: Text(role.nombre),
                              trailing: IconButton(
                                icon: const Icon(Icons.edit, color: Colors.green,),
                                onPressed: () {
                                  _showUpdateDialog(context, role);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('No hay roles disponibles'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateDialog(BuildContext context) {
    final _nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Crear Rol', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
          content: Form(
            key: _formKey, // Define un _formKey en tu State
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre del rol'),
              validator: (v) => v == null || v.isEmpty ? "Campo requerido" : null,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final rolDto = RolDto(nombre: _nameController.text);
                if (_formKey.currentState!.validate()) {
                  context.read<RolBloc>().add(CreateRolEvent(rolDto: rolDto));
                  Navigator.of(context).pop();
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, completa todos los campos requeridos.'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: const Text('Crear'),
            ),
          ],
        );
      },
    );
  }

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
}