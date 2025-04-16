import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/presentation/screens/bienvenida1.dart';
import 'package:turismo_flutter/presentation/screens/bienvenida2.dart';
import 'package:turismo_flutter/presentation/screens/home.dart';

class AppRouter {
  final bool showFirstTwoScreens;

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
    ],
  );
}
