import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turismo_flutter/data/models/rol_response.dart';
import 'package:turismo_flutter/data/services/login_service.dart';
import 'package:turismo_flutter/data/services/rol_service.dart';
import 'package:turismo_flutter/data/models/rol_dto.dart';

class AdminRolScreen extends StatefulWidget {
  const AdminRolScreen({super.key});

  @override
  _AdminRolScreenState createState() => _AdminRolScreenState();
}

class _AdminRolScreenState extends State<AdminRolScreen> {
  List<RolResponse> roles = [];
  bool isLoading = true;
  final RolService _rolService = RolService();

  @override
  void initState() {
    super.initState();
    _fetchRoles();
  }

  Future<void> _fetchRoles() async {
    try {
      final token = await LoginService().getSavedToken();
      if (token != null) {
        final fetchedRoles = await _rolService.obtenerRoles();
        setState(() {
          roles = fetchedRoles;
          isLoading = false;
        });
      } else {
        throw Exception("Token no encontrado");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar roles: $e")),
      );
      setState(() => isLoading = false);
    }
  }

  void _deleteRole(int index) {
    setState(() {
      roles.removeAt(index);
    });
  }

  // Mostrar cuadro de diálogo para agregar un nuevo rol
  void _showAddRoleDialog() {
    TextEditingController roleController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Agregar Nuevo Rol"),
          content: TextField(
            controller: roleController,
            decoration: const InputDecoration(hintText: 'Nombre del Rol'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (roleController.text.isNotEmpty) {
                  final newRolDto = RolDto(nombre: roleController.text);

                  try {
                    final newRol = await _rolService.crearRol(newRolDto);

                    setState(() {
                      roles.add(newRol); // Agregar el nuevo rol a la lista
                    });

                    Navigator.pop(context); // Cerrar el diálogo
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Rol agregado exitosamente")),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error al agregar el rol: $e")),
                    );
                  }
                }
              },
              child: const Text("Agregar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

  // Mostrar cuadro de diálogo para actualizar un rol
  void _showUpdateRoleDialog(int index) {
    TextEditingController roleController = TextEditingController();
    roleController.text = roles[index].nombre; // Inicializar con el nombre actual del rol

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Actualizar Rol"),
          content: TextField(
            controller: roleController,
            decoration: const InputDecoration(hintText: 'Nuevo nombre del Rol'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (roleController.text.isNotEmpty) {
                  final updatedRolDto = RolDto(nombre: roleController.text);

                  try {
                    // Llamar al servicio para actualizar el rol
                    final updatedRol = await _rolService.actualizarRol(
                        roles[index].idRol,
                        updatedRolDto
                    );

                    // Si la actualización fue exitosa, actualizar el rol en la lista
                    setState(() {
                      roles[index] = updatedRol; // Reemplazar el rol antiguo con el nuevo
                    });

                    Navigator.pop(context); // Cerrar el diálogo
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Rol actualizado exitosamente")),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error al actualizar el rol: $e")),
                    );
                  }
                }
              },
              child: const Text("Actualizar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: roles.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(roles[index].idRol.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) async {
              final rolId = roles[index].idRol;

              try {
                await _rolService.eliminarRol(rolId);
                setState(() {
                  roles.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Rol eliminado exitosamente")),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al eliminar el rol: $e')),
                );
              }
            },
            background: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            child: ListTile(
              title: Text(roles[index].nombre),
              trailing:  const Icon(Icons.edit),
              onTap: () => _showUpdateRoleDialog(index), // Agregar acción para editar el rol
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRoleDialog,
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}