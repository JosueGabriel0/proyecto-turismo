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

  int? _selectedLugarId;
  int? _selectedFamiliaId;
  int? _selectedFamiliaCategoriaId;
  int? _selectedEmprendimientoId;

  void _navigateToIndex(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateTo(int index, {int? id}) {
    setState(() {
      _selectedIndex = index;
      _selectedLugarId = id;
    });
  }
  
  void _navigateTo2(int index, {int? id}){
    setState(() {
      _selectedIndex = index;
      _selectedFamiliaId = id;
    });
  }

  void _navigateTo3(int index, {int? id}){
    setState(() {
      _selectedIndex = index;
      _selectedFamiliaCategoriaId = id;
    });
  }

  void _navigateTo4(int index, {int? id}){
    setState(() {
      _selectedIndex = index;
      _selectedEmprendimientoId = id;
    });
  }

  List<Widget> get _screens => [
    HomeMainDashboard(onNavigate: _navigateTo),
    FamiliasLugaresScreen(onNavigate: _navigateTo2, id: _selectedLugarId, onNavigateIndex: _navigateToIndex,),
    CategoriasPorFamiliaScreen(onNavigate: _navigateTo3, idFamilia: _selectedFamiliaId, onNavigateIndex: _navigateToIndex,),
    EmprendimientosFamiliaCategoriaScreen(onNavigate: _navigateTo4, idFamiliaCategoria: _selectedFamiliaCategoriaId, onNavigateIndex: _navigateToIndex,),
    EmprendimientoDetalleScreen(idEmprendimiento: _selectedEmprendimientoId, onNavigateIndex: _navigateToIndex)
  ];

  final List<String> _titles = [
    'Home',
    'Familias',
    'Categorias',
    'Emprendimientos',
    'Detalles',
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        body: _screens[_selectedIndex],
        // En el BottomNavigationBar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0, // <-- FIJO, no depende de _selectedIndex
          onTap: (index) {
            // Solo cambia la lógica del índice para mostrar pantallas
            setState(() {
              _selectedIndex = index;
            });
            // No actualices el currentIndex del BottomNavigationBar
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_rate),
              label: 'Rate',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Reserva',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Mensaje',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Usuario',
            ),
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
            decoration: const BoxDecoration(color: Color(0xFF2C6593)),
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
                  else if (_usuario!.persona?.fotoPerfil != null)
                    FotoWidget(
                      fileName: _usuario!.persona!.fotoPerfil!,
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
              setState(() => _selectedIndex = 0);
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