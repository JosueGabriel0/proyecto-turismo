import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/usuario_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/usuario/usuario_emprendedor_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/usuario/usuario_emprendedor_event.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/usuario/usuario_emprendedor_state.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/screens/emprendedor_dashboard_screen.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/screens/mensajes_emprendedor_screen.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/screens/mi_emprendimiento_screen.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/screens/mis_reservas_screen.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/screens/mis_servicios_screen.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/screens/perfil_emprendedor_screen.dart';

class EmprendedorScreen extends StatefulWidget {
  final Widget? child;
  const EmprendedorScreen({super.key, this.child});

  @override
  _EmprendedorScreenState createState() => _EmprendedorScreenState();
}

class _EmprendedorScreenState extends State<EmprendedorScreen> {
  //DRAWER
  int _selectedIndex = 0;

  void _setTabIndex(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        _bottomNavIndex = 0;
      });
    }
  }

  final List<Widget> _screens = [
    const DashboardEmprendedorScreen(),
    const MiEmprendimientoScreen(),
    const MisServiciosScreen(),
    const MisReservasScreen(),
  ];

  final List<String> _titles = [
    'Panel de Emprendedor',
    'Mi emprendimiento',
    'Mis Servicios',
    'Mis Reservas',
  ];

  final List<IconData> _icons = [
    Icons.dashboard,
    Icons.store,
    Icons.design_services,
    Icons.book_online,
  ];

  //BottomNavigationBar

  int _bottomNavIndex = 0;

  void _navigateToIndex(int index) {
    if (index == 0) {
      _selectedIndex = 0;
      context.go('/emprendedor');
    } else if (index == 1) {
      _selectedIndex = 9;
      context.go('/emprendedor/mensajes');
    } else if (index == 2) {
      _selectedIndex = 10;
      context.go('/emprendedor/perfil');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final tab = GoRouterState.of(context).uri.queryParameters['tab'];

    switch (tab) {
      case 'dashboard':
        _setTabIndex(0);
        break;
      case 'emprendimiento':
        _setTabIndex(1);
        break;
      case 'servicios':
        _setTabIndex(2);
        break;
      case 'reservas':
        _setTabIndex(3);
        break;
      default:
        _setTabIndex(0); // Dashboard por defecto
    }
  }

  UsuarioEmprendedorResponse? _usuario;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsuarioEmprendedorBloc>().add(GetMyUsuarioEmprendedorEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsuarioEmprendedorBloc, UsuarioEmprendedorState>(
      listener: (context, state) {
        if (state is UsuarioEmprendedorProfileLoaded) {
          setState(() {
            _usuario = state.usuario;
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
          backgroundColor: Colors.teal[700],
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
            final isEmprendedorBase = uri.path == '/emprendedor';
            final tabParam = uri.queryParameters['tab'];

            if (isEmprendedorBase) {
              return _screens[_selectedIndex];
            } else if (uri.path == '/emprendedor/mensajes') {
              return const MensajesEmprendedorScreen();
            } else if (uri.path == '/emprendedor/perfil') {
              return const PerfilEmprendedorScreen();
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
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Mensajes'),
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
          _usuario == null
              ? const DrawerHeader(child: Center(child: CircularProgressIndicator()))
              : DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal[700]),
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
                    child: Icon(Icons.person, size: 36, color: Colors.teal),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _usuario!.persona?.nombres ?? "Sin nombre",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              setState(() => _selectedIndex = 0);
              context.go('/emprendedor?tab=dashboard');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Mi emprendimiento'),
            onTap: () {
              setState(() => _selectedIndex = 1);
              context.go('/emprendedor?tab=emprendimiento');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.design_services),
            title: const Text('Mis Servicios'),
            onTap: () {
              setState(() => _selectedIndex = 2);
              context.go('/emprendedor?tab=servicios');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_online),
            title: const Text('Mis Reservas'),
            onTap: () {
              setState(() => _selectedIndex = 3);
              context.go('/emprendedor?tab=reservas');
              Navigator.of(context).pop();
            },
          ),
          const Spacer(),
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