import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home_dashboard/categorias_por_familia_screen.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home_dashboard/emprendimiento_detalle_screen.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home_dashboard/emprendimientos_familia_categoria_screen.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home_dashboard/familias_lugares_screen.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home_dashboard/file_screen.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home_dashboard/home_main_dashboard.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home_dashboard/reserva_screen.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_state.dart';

class Home extends StatefulWidget {
  final Widget? child;
  const Home({super.key, this.child});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isClickedLogin = false;
  bool _isClickedSignup = false;
  bool _isLoggedIn = false;

  int _bottomNavIndex = 0;  // índice para el BottomNavigationBar
  int _screenIndex = 0;     // índice para controlar las pantallas que se muestran

  int? _selectedLugarId;
  int? _selectedFamiliaId;
  int? _selectedFamiliaCategoriaId;
  int? _selectedEmprendimientoId;

  void _navigateToIndex(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  void _navigateToBottomNavIndex(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  void _navigateToScreen(int index, {int? id}) {
    setState(() {
      _screenIndex = index;  // cambia pantalla sin alterar bottomNavIndex

      switch (index) {
        case 1:
          _selectedLugarId = id;
          break;
        case 2:
          _selectedFamiliaId = id;
          break;
        case 3:
          _selectedFamiliaCategoriaId = id;
          break;
        case 4:
        case 5:
          _selectedEmprendimientoId = id;
          break;
        default:
          _selectedLugarId = null;
          _selectedFamiliaId = null;
          _selectedFamiliaCategoriaId = null;
          _selectedEmprendimientoId = null;
      }
    });
  }

  List<Widget> get _screens =>
      [
        HomeMainDashboard(onNavigate: _navigateToScreen),
        FamiliasLugaresScreen(onNavigate: _navigateToScreen,
          id: _selectedLugarId,
          onNavigateIndex: _navigateToIndex,),
        CategoriasPorFamiliaScreen(onNavigate: _navigateToScreen,
          key: ValueKey(_selectedFamiliaId),
          idFamilia: _selectedFamiliaId,
          onNavigateIndex: _navigateToIndex,),
        EmprendimientosFamiliaCategoriaScreen(onNavigate: _navigateToScreen,
          idFamiliaCategoria: _selectedFamiliaCategoriaId,
          onNavigateIndex: _navigateToIndex,),
        EmprendimientoDetalleScreen(onNavigate: _navigateToScreen,
            idEmprendimiento: _selectedEmprendimientoId,
            onNavigateIndex: _navigateToIndex),
        ReservaScreen(idEmprendimiento: _selectedEmprendimientoId,
          onNavigateIndex: _navigateToIndex, onNavigateIndexBottomNav: _navigateToBottomNavIndex),
      ];

  final List<String> _titles = [
    'Home',
    'Familias',
    'Categorias',
    'Emprendimientos',
    'Detalles',
    'Reserva',
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final uri = GoRouterState.of(context).uri.toString();
    int? newIndex;

    switch (uri) {
      case '/home':
        newIndex = 0;
        break;
      case '/rate':
        newIndex = 1;
        break;
      case '/home/reserva':
        newIndex = 2;
        break;
      case '/home/chat':
        newIndex = 3;
        break;
      case '/home/perfil':
        newIndex = 4;
        break;
    }

    if (newIndex != null && newIndex != _bottomNavIndex) {
      setState(() {
        _bottomNavIndex = newIndex ?? 0;
      });
    }
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

  String _getTitle() {
    final uri = GoRouterState.of(context).uri.toString();
    if (uri == '/home') {
      return _titles[_screenIndex];
    } else if (uri == '/rate') {
      return 'Rate';
    } else if (uri == '/home/reserva') {
      return 'Reservas';
    } else if (uri == '/home/chat') {
      return 'Chat';
    } else if (uri == '/home/perfil') {
      return 'Usuario';
    }
    return 'Turismo App';
  }


  Widget _buildBody() {
    final uri = GoRouterState.of(context).uri.toString();

    if (uri == '/home') {
      // Aquí muestro según _screenIndex (que puede ir más allá del rango del BottomNav)
      return _screens[_screenIndex];
    }

    return widget.child ?? const SizedBox();
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
          title: Text(_getTitle(), style: const TextStyle(color: Colors.white),),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF3A506B),
          actions: _isLoggedIn
          ? [
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
              _isLoggedIn = false;
              _usuario = null;
            });
            context.go("/login");
          },
        ),
      ]
          : [
        AnimatedButton(
          text: 'LogIn',
          onPress: () {
            setState(() => _isClickedLogin = !_isClickedLogin);
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
        const SizedBox(width: 10),
        AnimatedButton(
          text: 'SignUp',
          onPress: () {
            setState(() => _isClickedSignup = !_isClickedSignup);
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
        const SizedBox(width: 10),
      ],
    ),
        drawer: _buildDrawer(),
        body: _buildBody(),
        // En el BottomNavigationBar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          selectedItemColor: Colors.black,       // Color cuando está seleccionado
          unselectedItemColor: Colors.grey[700], // Color plomo cuando no está seleccionado
          onTap: (index) {
            _navigateToIndex(index);

            switch (index) {
              case 0:
                context.go('/home');
                break;
              case 1:
                context.go('/rate');
                break;
              case 2:
                context.go('/home/reserva');
                break;
              case 3:
                context.go('/home/chat');
                break;
              case 4:
                context.go('/home/perfil');
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
            BottomNavigationBarItem(icon: Icon(Icons.star_rate), label: 'Rate'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Reserva'),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Usuario'),
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
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF3A506B)),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_isLoggedIn || _usuario == null)
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 36, color: Colors.blueGrey),
                    )
                  else if (_usuario?.persona?.fotoPerfil != null)
                    FotoWidget(
                      fileName: _usuario?.persona?.fotoPerfil ?? "",
                      size: 60,
                    )
                  else
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 36, color: Colors.blueGrey),
                    ),
                  const SizedBox(height: 10),
                  Text(
                    !_isLoggedIn
                        ? "Invitado"
                        : (_usuario?.persona?.nombres ?? "Sin nombre"),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    !_isLoggedIn
                        ? "Sin sesión"
                        : (_usuario?.persona?.correoElectronico ?? "Sin correo"),
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
              setState(() => _screenIndex = 0);
              Navigator.of(context).pop();
            },
          ),
          const Spacer(),
          if (_isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () async {
                final tokenService = TokenStorageService();
                await tokenService.clearToken();

                setState(() {
                  _isLoggedIn = false;
                  _usuario = null;
                });

                context.go("/login");
              },
            ),
        ],
      ),
    );
  }
}