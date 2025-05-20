import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/admin_screen.dart';
import 'package:turismo_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:turismo_flutter/features/auth/presentation/screens/register_screen.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/screens/emprendedor_screen.dart';
import 'package:turismo_flutter/features/general/presentation/screens/bienvenida1.dart';
import 'package:turismo_flutter/features/general/presentation/screens/bienvenida2.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home.dart';
import 'package:turismo_flutter/features/usuario/presentation/screens/usuario_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
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
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminScreen(),
    ),
    GoRoute(
      path: '/usuario',
      builder: (context, state) => const UsuarioScreen(),
    ),
    GoRoute(
      path: '/emprendedor',
      builder: (context, state) => const EmprendedorScreen(),
    ),
  ],
);
