import 'package:flutter/material.dart';
import 'package:turismo_flutter/config/routes/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pantallas con go_router',
      theme: ThemeData(fontFamily: 'RobotoMono'),
      routerConfig: appRouter,
    );
  }
}