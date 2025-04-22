import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_flutter/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/data/repositories_impl/usuario_repository.dart';
import 'package:turismo_flutter/data/services/login_service.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/data/services/usuario_service.dart';
import 'package:turismo_flutter/presentation/screens/home_admin/AdminDashboardScreen.dart';
import 'package:turismo_flutter/presentation/screens/home_admin/AdminRolScreen.dart';
import 'package:turismo_flutter/presentation/screens/home_admin/AdminUsuarioScreen.dart';
import 'package:turismo_flutter/presentation/screens/home_admin/admin_view_enum.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  _HomeAdminScreenState createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AdminView _selectedView = AdminView.dashboard;
  String? _userName;
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    _getTokenAndUserData();
  }

  Future<void> _getTokenAndUserData() async {
    try {
      // Obtén el token desde SharedPreferences
      final token = await LoginService().getSavedToken();
      final prefs = await SharedPreferences.getInstance();
      final idUsuario = prefs.getInt('idUsuario');  // El idUsuario sigue estando en SharedPreferences

      // Verifica que el token y idUsuario no sean nulos
      if (token != null && idUsuario != null) {
        // Ahora, UsuarioService crea internamente el repositorio
        final usuarioService = UsuarioService();

        // Llama al servicio para obtener los datos del usuario desde el backend
        final usuario = await usuarioService.obtenerUsuarioPorId(idUsuario);

        // Aquí solo asignas los datos a las variables locales (_userName y _userEmail)
        setState(() {
          _userName = '${usuario.persona.nombres} ${usuario.persona.apellidos}';
          _userEmail = usuario.persona.correoElectronico;
        });
      } else {
        _mostrarError('No se encontró el token o el ID de usuario.');
      }
    } catch (e) {
      // Maneja errores si ocurre algún problema al obtener los datos
      _mostrarError('Ocurrió un error al obtener los datos del usuario: $e');
    }
  }

  void _mostrarError(String mensaje) {
    // Muestra un error en un SnackBar si ocurre algún problema
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  void _changeView(AdminView view) {
    setState(() {
      _selectedView = view;
    });
    Navigator.pop(context); // Cierra el Drawer después de seleccionar
  }

  Widget _getCurrentView() {
    switch (_selectedView) {
      case AdminView.dashboard:
        return const AdminDashboardScreen();
      case AdminView.usuarios:
        return const AdminUsuarioScreen();
      case AdminView.roles:
        return const AdminRolScreen();
    }
  }

  String _getTitle(AdminView view) {
    switch (view) {
      case AdminView.dashboard:
        return 'Dashboard Admin';
      case AdminView.usuarios:
        return 'Gestión de Usuarios';
      case AdminView.roles:
        return 'Gestión de roles';
      default:
        return 'Dashboard Admin';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_getTitle(_selectedView)),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Abre el Drawer
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/rive_logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _userName != null && _userName!.isNotEmpty
                      ? Text(
                    _userName!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                      : const Text(
                    'Nombre no disponible',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  _userEmail != null && _userEmail!.isNotEmpty
                      ? Text(
                    _userEmail!,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  )
                      : const Text(
                    'Correo no disponible',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                _changeView(AdminView.dashboard); // Cambia a la vista de Dashboard
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Usuarios'),
              onTap: () {
                _changeView(AdminView.usuarios); // Cambia a la vista de Usuarios
              },
            ),
            ListTile(
              leading: const Icon(Icons.face),
              title: const Text('Roles'),
              onTap: () {
                _changeView(AdminView.roles); // Cambia a la vista de Roles
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
      body: _getCurrentView(),
    );
  }
}