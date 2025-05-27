import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_state.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/admin_dashboard_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/categoria_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/emprendimiento_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/familia_categoria_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/familia_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/lugar_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/rol_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/servicio_turistico_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/usuario_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/pages/home2_page.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/pages/home_page.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/screens/emprendedor_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  // Índice para controlar la pantalla actual
  int _selectedIndex = 0;

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

  // Lista de títulos correspondientes a cada pantalla
  final List<String> _titles = [
    'Panel de Administración',
    'Gestión de roles',
    'Gestión de usuarios',
    'Gestión de lugares',
    'Gestion de familias',
    'Gestion de categorias',
    'Gestion de familia con categoria',
    'Gestion de emprendimientos',
    'Gestion de servicios turisticos',
  ];

  // Guardar el usuario en una variable para la pantalla
  UsuarioCompletoResponse? _usuario;

  @override
  void initState() {
    super.initState();
    print("Bloc encontrado: ${context.read<UsuarioBloc>()}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsuarioBloc>().add(GetMyUsuarioEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsuarioBloc, UsuarioState>(
      listener: (context, state) {
        if (state is UsuarioProfileLoaded) {
          setState(() {
            _usuario = state.usuario;  // Actualizamos el estado del usuario
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titles[_selectedIndex], style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blueGrey[800],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: _buildDrawer(),
        body: _screens[_selectedIndex], // Cambia el contenido basado en el índice seleccionado
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
              setState(() => _selectedIndex = 0);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Roles'),
            onTap: () {
              setState(() => _selectedIndex = 1);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Usuarios'),
            onTap: () {
              setState(() => _selectedIndex = 2);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.place),
            title: const Text('Lugares'),
            onTap: () {
              setState(() => _selectedIndex = 3);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.family_restroom),
            title: const Text('Familias'),
            onTap: () {
              setState(() => _selectedIndex = 4);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categorias'),
            onTap: () {
              setState(() => _selectedIndex = 5);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.private_connectivity),
            title: const Text('Familias con Categorias'),
            onTap: () {
              setState(() => _selectedIndex = 6);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Emprendimientos'),
            onTap: () {
              setState(() => _selectedIndex = 7);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.design_services),
            title: const Text('Servicios turisticos'),
            onTap: () {
              setState(() => _selectedIndex = 8);
              Navigator.of(context).pop();
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