import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/data/services/login_service.dart';
import 'package:turismo_flutter/presentation/screens/HomeAdminScreen.dart';
import 'package:turismo_flutter/presentation/screens/HomeUsuarioScreen.dart';
import 'package:turismo_flutter/presentation/screens/LoginScreen.dart';
import 'package:turismo_flutter/presentation/screens/bienvenida1.dart';
import 'package:turismo_flutter/presentation/screens/bienvenida2.dart';
import 'package:turismo_flutter/presentation/screens/home.dart';

class AppRouter {
  final bool showFirstTwoScreens;
  final LoginService _loginService = LoginService();

  AppRouter({required this.showFirstTwoScreens});

  late final GoRouter router = GoRouter(
    initialLocation: showFirstTwoScreens ? '/' : '/home',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Bienvenida1(),
      ),
      GoRoute(
        path: '/bienvenida2',
        builder: (context, state) => const Bienvenida2(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/homeAdmin',
        builder: (context, state) => const HomeAdminScreen(),
      ),
      GoRoute(
        path: '/homeUsuario',
        builder: (context, state) => const HomeUsuarioScreen(),
      ),
    ],
  );
}
