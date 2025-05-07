import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';

class UsuarioScreen extends StatelessWidget {
  const UsuarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Panel de Usuario"),
        backgroundColor: Colors.blueGrey[900],
      ),
      drawer: _buildDrawer(context),
      body: const Center(
        child: Text(
          'Bienvenido al panel de usuario',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[100],
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey[800]),
            accountName: const Text("Administrador"),
            accountEmail: const Text("admin@turismo.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.admin_panel_settings, size: 36, color: Colors.blueGrey),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              context.go('/admin/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Usuarios'),
            onTap: () {
              context.go('/admin/users');
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Lugares turísticos'),
            onTap: () {
              context.go('/admin/places');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () {
              final tokenService = TokenStorageService();

              Future<void> logout() async {
                await tokenService.clearToken(); // Elimina el token
                context.go('/login');
              }
              logout();
            },
          ),
        ],
      ),
    );
  }
}