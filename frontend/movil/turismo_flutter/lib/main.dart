import 'package:flutter/material.dart';
import 'package:turismo_flutter/config/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final bool showFirstTwoScreens = true;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter(showFirstTwoScreens: showFirstTwoScreens);

    return MaterialApp.router(
      routerConfig: appRouter.router,
      theme: ThemeData(fontFamily: 'RobotoMono'),
      title: 'Pantallas con go_router',
    );
  }
}