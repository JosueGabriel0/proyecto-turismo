import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home_dashboard/home_main_dashboard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isClickedLogin = false;
  bool _isClickedSignup = false;

  // Índice para controlar la pantalla actual
  int _selectedIndex = 0;

  // Lista de pantallas que pueden mostrarse
  final List<Widget> _screens = [
    const HomeMainDashboard(),
  ];

  // Lista de títulos correspondientes a cada pantalla
  final List<String> _titles = [
    'Home',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          AnimatedButton(
            text: 'Log in',
            onPress: () {
              setState(() {
                _isClickedLogin = !_isClickedLogin;
              });
              context.go('/login');
            },
            textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _isClickedLogin ? Colors.white : Colors.black
            ),
            backgroundColor: _isClickedLogin ? Colors.grey : Color(0xFF5AC7F5),
            borderRadius: 10,
            borderWidth: 2,
            borderColor: Colors.black,
            isReverse: _isClickedLogin,
            transitionType: TransitionType.LEFT_TO_RIGHT,
            width: 85,
            height: 30,
          ),
          SizedBox(width: 10),
          AnimatedButton(
            text: 'Sign up',
            onPress: () {
              setState(() {
                _isClickedSignup = !_isClickedSignup;
              });
              context.go('/home');
            },
            textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _isClickedSignup ? Colors.white : Colors.black
            ),
            backgroundColor: _isClickedSignup ? Colors.grey : Color(0xFF5AC7F5),
            borderRadius: 10,
            borderWidth: 2,
            borderColor: Colors.black,
            isReverse: _isClickedSignup,
            transitionType: TransitionType.LEFT_TO_RIGHT,
            width: 85,
            height: 30,),
          SizedBox(width: 10)
        ],
      ),
      drawer: _buildDrawer(),
      body: _screens[_selectedIndex],
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.grey[100],
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF2C6593)),
            accountName: const Text("Ejemplo"),
            accountEmail: const Text("ejemplo@turismo.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.admin_panel_settings, size: 36,
                  color: Color(0xFF5AC7F5)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}