import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/perfil/perfil_admin_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/perfil/perfil_admin_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/perfil/perfil_admin_state.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/admin_dashboard_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/categoria_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/emprendimiento_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/familia_categoria_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/familia_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/lugar_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/rol_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/servicio_turistico_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/usuario_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/noticias_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/perfil_admin_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';

class AdminScreen extends StatefulWidget {
  final Widget? child;
  const AdminScreen({super.key, this.child});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final tab = GoRouterState.of(context).uri.queryParameters['tab'];

    switch (tab) {
      case 'dashboard':
        _setTabIndex(0);
        break;
      case 'roles':
        _setTabIndex(1);
        break;
      case 'usuarios':
        _setTabIndex(2);
        break;
      case 'lugares':
        _setTabIndex(3);
        break;
      case 'familias':
        _setTabIndex(4);
        break;
      case 'categorias':
        _setTabIndex(5);
        break;
      case 'famcat':
        _setTabIndex(6);
        break;
      case 'emprendimientos':
        _setTabIndex(7);
        break;
      case 'servicios':
        _setTabIndex(8);
        break;
      default:
        _setTabIndex(0); // Dashboard por defecto
    }
  }

  void _setTabIndex(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        _bottomNavIndex = 0;
      });
    }
  }

  // Índice para controlar la pantalla actual
  int _selectedIndex = 0;

  void _navigateToIndex(int index) {
      if (index == 0) {
        _selectedIndex = 0;
        context.go('/admin');
      } else if (index == 1) {
        _selectedIndex = 9;
        context.go('/admin/noticias');
      } else if (index == 2) {
        _selectedIndex = 10;
        context.go('/admin/chat');
      } else if (index == 3) {
        _selectedIndex = 11;
        context.go('/admin/perfil');
      }
  }

  int _bottomNavIndex = 0;
  // Lista de pantallas que pueden mostrarse
  final List<Widget> _screens = [
    const AdminDashboardScreen(),
    const RolScreen(),
    const UsuarioScreen(),
    const LugarScreen(),
    const FamiliaScreen(),
    const CategoriaScreen(),
    const FamiliaCategoriaScreen(),
    const EmprendimientoScreen(),
    const ServicioTuristicoScreen(),
  ];

  final List<IconData> _icons = [
    Icons.dashboard,          // Panel de Administración
    Icons.admin_panel_settings, // Roles
    Icons.person,             // Usuarios
    Icons.place,              // Lugares
    Icons.family_restroom,    // Familias
    Icons.category,           // Categorias
    Icons.merge_type,         // Familia Categoria
    Icons.business,           // Emprendimientos
    Icons.tour,               // Servicios turisticos
    Icons.newspaper,
    Icons.person_pin,
  ];

  // Lista de títulos correspondientes a cada pantalla
  final List<String> _titles = [
    'Administración',
    'Roles',
    'Usuarios',
    'Lugares',
    'Familias',
    'Categorias',
    'Familia Categoria',
    'Emprendimientos',
    'Servicios turisticos',
    'Noticias',
    'Perfil'
  ];

  // Guardar el usuario en una variable para la pantalla
  UsuarioCompletoResponse? _usuario;

  @override
  void initState() {
    super.initState();
    print("Bloc encontrado: ${context.read<PerfilAdminBloc>()}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PerfilAdminBloc>().add(LoadPerfilAdminEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final uri = GoRouterState.of(context).uri;
    final path = uri.path;

    if (path.startsWith('/admin/chat')) {
      _bottomNavIndex = 2;
    } else if (path == '/admin') {
      _bottomNavIndex = 0;
    } else if (path == '/admin/noticias') {
      _bottomNavIndex = 1;
    } else if (path == '/admin/perfil') {
      _bottomNavIndex = 3;
    }
    return BlocListener<PerfilAdminBloc, PerfilAdminState>(
      listener: (context, state) {
        if (state is PerfilAdminLoaded) {
          setState(() {
            _usuario = state.usuario;  // Actualizamos el estado del usuario
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                Icon(_icons[_selectedIndex], color: Colors.white),
                SizedBox(width: 8),
                Expanded( // Esto limita el ancho del texto al espacio disponible
                  child: Text(
                    _titles[_selectedIndex],
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.blueGrey[800],
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Acción de notificaciones
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Acción de configuración
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  final tokenService = TokenStorageService();
                  await tokenService.clearToken();
                  setState(() {
                    _usuario = null;
                  });
                  context.go("/login");
                },
              ),
            ]
        ),
        drawer: _buildDrawer(),
        body: Builder(
          builder: (context) {
            final uri = GoRouterState.of(context).uri;
            final isAdminBase = uri.path == '/admin';
            final tabParam = uri.queryParameters['tab'];

            if (isAdminBase) {
              return _screens[_selectedIndex];
            } else if (uri.path == '/admin/noticias') {
              return const NoticiasScreen();
            } else if (uri.path == '/admin/perfil') {
              return const PerfilAdminScreen();
            }

            return widget.child ?? const SizedBox();
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          onTap: _navigateToIndex,
          selectedItemColor: Colors.blueGrey[800],
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Noticias'),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Perfil'),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.grey[100],
      child: Column(
        children: [
          // Header con info de usuario
          _usuario == null
              ? const DrawerHeader(
            child: Center(child: CircularProgressIndicator()),
          )
              : DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey[800]),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _usuario!.persona?.fotoPerfil != null
                      ? FotoWidget(
                    fileName: _usuario!.persona!.fotoPerfil!,
                    size: 60,
                  )
                      : const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person,
                        size: 36, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _usuario!.persona?.nombres ?? "Sin nombre",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _usuario!.persona?.correoElectronico ?? "Sin correo",
                    style: const TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Menú de opciones
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              setState(() {
                _selectedIndex = 0;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings),
            title: const Text('Roles'),
            onTap: () {
              setState(() {
                _selectedIndex = 1;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=roles');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Usuarios'),
            onTap: () {
              setState(() {
                _selectedIndex = 2;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=usuarios');
            },
          ),
          ListTile(
            leading: const Icon(Icons.place),
            title: const Text('Lugares'),
            onTap: () {
              setState(() {
                _selectedIndex = 3;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=lugares');
            },
          ),
          ListTile(
            leading: const Icon(Icons.family_restroom),
            title: const Text('Familias'),
            onTap: () {
              setState(() {
                _selectedIndex = 4;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=familias');
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categorias'),
            onTap: () {
              setState(() {
                _selectedIndex = 5;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=categorias');
            },
          ),
          ListTile(
            leading: const Icon(Icons.merge_type),
            title: const Text('Familias con Categorias'),
            onTap: () {
              setState(() {
                _selectedIndex = 6;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=famcat');
            },
          ),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Emprendimientos'),
            onTap: () {
              setState(() {
                _selectedIndex = 7;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=emprendimientos');
            },
          ),
          ListTile(
            leading: const Icon(Icons.tour),
            title: const Text('Servicios turisticos'),
            onTap: () {
              setState(() {
                _selectedIndex = 8;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=servicios');
            },
          ),

          const Spacer(), // <- Este empuja el siguiente widget al final

          // Cerrar sesión
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () async {
              final tokenService = TokenStorageService();
              await tokenService.clearToken();
              context.go("/login");
            },
          ),
        ],
      ),
    );
  }

}