import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_state.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home_dashboard/home_main_dashboard.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isClickedLogin = false;
  bool _isClickedSignup = false;
  bool _isLoggedIn = false;

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeMainDashboard(),
  ];

  final List<String> _titles = [
    'Home',
  ];

  UsuarioUserResponse? _usuario;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsuarioUserBloc>().add(GetMyUsuarioUserEvent());
    });
  }

  Future<void> _checkIfLoggedIn() async {
    final tokenService = TokenStorageService();
    final token = await tokenService.getToken();

    if (token != null && token.isNotEmpty) {
      final role = getRoleFromToken(token);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (role == 'ROLE_ADMIN') {
          context.go('/admin');
        } else if (role == 'ROLE_EMPRENDEDOR') {
          context.go('/emprendedor');
        }
        // ROLE_USUARIO se queda en /home
      });

      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsuarioUserBloc, UsuarioUserState>(
      listener: (context, state) {
        if (state is UsuarioUserProfileLoaded) {
          setState(() {
            _usuario = state.usuario;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titles[_selectedIndex]),
          actions: _isLoggedIn
              ? []
              : [
            AnimatedButton(
              text: 'LogIn',
              onPress: () {
                setState(() {
                  _isClickedLogin = !_isClickedLogin;
                });
                context.go('/login');
              },
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _isClickedLogin ? Colors.black : Colors.white,
              ),
              backgroundColor: _isClickedLogin ? Colors.cyan : Colors.blue,
              borderRadius: 10,
              borderWidth: 2,
              borderColor: Colors.blueGrey,
              isReverse: _isClickedLogin,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              width: 85,
              height: 30,
            ),
            SizedBox(width: 10),
            AnimatedButton(
              text: 'SignUp',
              onPress: () {
                setState(() {
                  _isClickedSignup = !_isClickedSignup;
                });
                context.go('/register');
              },
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _isClickedSignup ? Colors.black : Colors.white,
              ),
              backgroundColor: _isClickedSignup ? Colors.cyan : Colors.blue,
              borderRadius: 10,
              borderWidth: 2,
              borderColor: Colors.blueGrey,
              isReverse: _isClickedSignup,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              width: 85,
              height: 30,
            ),
            SizedBox(width: 10),
          ],
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
              ? const DrawerHeader(
            child: Center(child: CircularProgressIndicator()),
          )
              : DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF2C6593)),
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
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              setState(() => _selectedIndex = 0);
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