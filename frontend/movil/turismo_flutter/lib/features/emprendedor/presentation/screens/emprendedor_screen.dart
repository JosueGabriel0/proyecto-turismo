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
import 'package:turismo_flutter/features/emprendedor/presentation/screens/mi_emprendimiento_screen.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/screens/mis_reservas_screen.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/screens/mis_servicios_screen.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_state.dart';

class EmprendedorScreen extends StatefulWidget {
  const EmprendedorScreen({super.key});

  @override
  _EmprendedorScreenState createState() => _EmprendedorScreenState();
}

class _EmprendedorScreenState extends State<EmprendedorScreen> {
  int _selectedIndex = 0;

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
          title: Text(_titles[_selectedIndex], style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.teal[700],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: _buildDrawer(),
        body: _screens[_selectedIndex],
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
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Mi emprendimiento'),
            onTap: () {
              setState(() => _selectedIndex = 1);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.design_services),
            title: const Text('Mis Servicios'),
            onTap: () {
              setState(() => _selectedIndex = 2);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_online),
            title: const Text('Mis Reservas'),
            onTap: () {
              setState(() => _selectedIndex = 3);
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