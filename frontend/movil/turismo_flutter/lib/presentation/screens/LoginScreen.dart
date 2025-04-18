import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart' as rive;
import 'package:turismo_flutter/config/theme/app_color.dart';
import 'package:turismo_flutter/data/models/login_dto.dart';
import 'package:turismo_flutter/data/services/login_service.dart';
import 'package:turismo_flutter/presentation/dialogs/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginService = LoginService();

  /// input form controller
  FocusNode emailFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();

  /// rive controller and input
  rive.StateMachineController? controller;

  rive.SMIInput<bool>? isChecking;
  rive.SMIInput<double>? numLook;
  rive.SMIInput<bool>? isHandsUp;

  rive.SMIInput<bool>? trigSuccess;
  rive.SMIInput<bool>? trigFail;

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    print("Build Called Again");
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Container(
              height: 64,
              width: 64,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Image(
                image: AssetImage("assets/images/rive_logo.png"),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Bienvenido al sistema de turismo Capachica",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 250,
              width: 250,
              child: rive.RiveAnimation.asset(
                "assets/images/login-teddy.riv",
                fit: BoxFit.fitHeight,
                stateMachines: const ["Login Machine"],
                onInit: (artboard) {
                  controller = rive.StateMachineController.fromArtboard(
                    artboard,

                    /// from rive, you can see it in rive editor
                    "Login Machine",
                  );
                  if (controller == null) return;

                  artboard.addController(controller!);
                  isChecking = controller?.findInput("isChecking");
                  numLook = controller?.findInput("numLook");
                  isHandsUp = controller?.findInput("isHandsUp");
                  trigSuccess = controller?.findInput("trigSuccess");
                  trigFail = controller?.findInput("trigFail");
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextField(
                      focusNode: emailFocusNode,
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "User Name",
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                      onChanged: (value) {
                        numLook?.change(value.length.toDouble());
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextField(
                      focusNode: passwordFocusNode,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                      ),
                      obscureText: true,
                      style: Theme.of(context).textTheme.bodyMedium,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 64,
                    child: ElevatedButton(
                        onPressed: () async {
                          emailFocusNode.unfocus();
                          passwordFocusNode.unfocus();

                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          // Mostrar el diálogo de carga
                          showLoadingDialog(context);

                          try {
                            if (email.isEmpty || password.isEmpty) {
                              if (mounted) Navigator.pop(context); // Cierra el loading si está abierto

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Completa todos los campos")),
                              );
                              return;
                            }

                            final role = await loginService.loginAndSaveToken(LoginDto(
                              username: email,
                              password: password,
                            ));

                            if (mounted) Navigator.pop(context); // Ocultar loading

                            // Activar animación de éxito
                            trigSuccess?.change(true);

                            // Esperar un poco antes de redirigir
                            await Future.delayed(const Duration(milliseconds: 1500));

                            // Redirigir según el rol
                            if (role == 'ROLE_ADMIN') {
                              context.go('/homeAdmin');
                            } else if (role == 'ROLE_USUARIO') {
                              context.go('/homeUsuario');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Rol no reconocido")),
                              );
                            }

                          } catch (e) {
                            if (mounted) Navigator.pop(context); // Ocultar loading si falla

                            // Activar animación de fallo
                            trigFail?.change(true);

                            // Mostrar error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Error al iniciar sesión: ${e.toString()}"),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text("Login"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
          Positioned(
            top: 20, // Ajusta según necesites para dar espacio al top
            left: 0, // Ajusta según necesites para dar espacio al left
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.go("/home"),
            ),
          ),
    ],
      ),
    );
  }
}