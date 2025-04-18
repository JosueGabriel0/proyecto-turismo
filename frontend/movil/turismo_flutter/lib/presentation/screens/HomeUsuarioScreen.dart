import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/data/services/login_service.dart';

class HomeUsuarioScreen extends StatefulWidget {
  const HomeUsuarioScreen({super.key});

  @override
  _HomeUsuarioScreenState createState() => _HomeUsuarioScreenState();
}

class _HomeUsuarioScreenState extends State<HomeUsuarioScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Dashboard Usuario'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Abre el Drawer
          },
        ),
        actions: [
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'Menú de Admin',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                // Navega a otra sección si quieres
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Usuarios'),
              onTap: () {
                Navigator.pop(context);
                context.go('/admin/usuarios'); // ruta de ejemplo
              },
            ),
            ListTile(
              leading: const Icon(Icons.face),
              title: const Text('Roles'),
              onTap: () {
                Navigator.pop(context);
                context.go('/admin/usuarios'); // ruta de ejemplo
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () async {
                Navigator.pop(context);
                await LoginService().logout();
                context.go('/login');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Home'),
          ],
        ),
      ),
    );
  }
}