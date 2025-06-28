import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/features/admin/data/models/chat_resumen_dto.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/admin_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/chat_admin_personal_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/chat_admin_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/noticias_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/perfil_admin_screen.dart';
import 'package:turismo_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:turismo_flutter/features/auth/presentation/screens/register_screen.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/screens/emprendedor_screen.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/screens/perfil_emprendedor_screen.dart';
import 'package:turismo_flutter/features/general/presentation/screens/bienvenida1.dart';
import 'package:turismo_flutter/features/general/presentation/screens/bienvenida2.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home.dart';
import 'package:turismo_flutter/features/general/presentation/screens/home_dashboard/reservas_screen.dart';
import 'package:turismo_flutter/features/usuario/presentation/screens/chat_usuario_screen.dart';
import 'package:turismo_flutter/features/usuario/presentation/screens/perfil_user_screen.dart';
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
      path: '/admin/noticias',
      builder: (context, state) => const AdminScreen(child: NoticiasScreen(),),
    ),
    GoRoute(
      path: '/admin/chat',
      builder: (context, state) => const AdminScreen(child: ChatAdminScreen(),),
    ),
    GoRoute(
      path: '/admin/chatPersonal/:id/:username',
      builder: (context, state) {
        final idUsuario = state.pathParameters['id'];
        final username = state.pathParameters['username'];
        final extras = state.extra as Map<String, dynamic>;

        return AdminScreen(
          child: ChatAdminPersonalScreen(
            idUsuario: idUsuario,
            username: username,
            chat: extras['chat'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/admin/perfil',
      builder: (context, state) => const AdminScreen(child: PerfilAdminScreen(),),
    ),
    GoRoute(
      path: '/usuario',
      builder: (context, state) => const UsuarioScreen(),
    ),
    GoRoute(
      path: '/emprendedor',
      builder: (context, state) => const EmprendedorScreen(),
    ),
    GoRoute(
      path: '/emprendedor/perfil',
      builder: (context, state) => const EmprendedorScreen(child: PerfilEmprendedorScreen(),),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const Home(), // solo carga el Home vacío
    ),
    GoRoute(
      path: '/home/reserva',
      builder: (context, state) => const Home(child: ReservasScreen(),),
    ),
    GoRoute(
      path: '/home/chat',
      builder: (context, state) => const Home(child: ChatUsuarioScreen(),),
    ),
    GoRoute(
      path: '/home/perfil',
      builder: (context, state) => const Home(child: PerfilUserScreen(),),
    ),
  ],
);