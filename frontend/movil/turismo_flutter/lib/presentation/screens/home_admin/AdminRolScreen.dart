import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminRolScreen extends StatefulWidget {
  const AdminRolScreen({super.key});

  @override
  _AdminRolScreenState createState() => _AdminRolScreenState();
}

class _AdminRolScreenState extends State<AdminRolScreen> {
  List<String> roles = ["Admin", "User", "Moderator", "Guest"];

  void _addRole(String role) {
    setState(() {
      roles.add(role);
    });
  }

  void _deleteRole(int index) {
    setState(() {
      roles.removeAt(index);
    });
  }

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
              onPressed: () {
                if (roleController.text.isNotEmpty) {
                  _addRole(roleController.text);
                  Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: roles.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(roles[index]),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              _deleteRole(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${roles[index]} ha sido eliminado')),
              );
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
              title: Text(roles[index]),
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