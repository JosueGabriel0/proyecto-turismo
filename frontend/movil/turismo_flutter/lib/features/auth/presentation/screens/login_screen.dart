import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart' as rive;
import 'package:turismo_flutter/config/theme/app_color.dart';
import 'package:turismo_flutter/features/auth/domain/usecases/login_usecase.dart';
import 'package:turismo_flutter/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:turismo_flutter/features/auth/presentation/bloc/login/login_event.dart';
import 'package:turismo_flutter/features/auth/presentation/bloc/login/login_state.dart';
import 'package:turismo_flutter/features/auth/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:turismo_flutter/injection/injection.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final useCase = getIt<LoginUseCase>();
        print("Obtenido desde getIt(): $useCase");
        return LoginBloc(loginUseCase: useCase);
      },
      child: const LoginContent(),
    );
  }
}

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();

  final FocusNode passwordFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isBlinking = false;

  rive.StateMachineController? controller;
  rive.SMIInput<bool>? isChecking;
  rive.SMIInput<double>? numLook;
  rive.SMIInput<bool>? isHandsUp;
  rive.SMIInput<bool>? trigSuccess;
  rive.SMIInput<bool>? trigFail;

  @override
  void initState() {
    emailFocusNode.addListener(() {
      isChecking?.change(emailFocusNode.hasFocus);
    });
    passwordFocusNode.addListener(() {
      isHandsUp?.change(passwordFocusNode.hasFocus);
    });
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      body: Stack(
        children: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginLoading) {
                showLoadingDialog(context);
              }

              if (state is LoginSuccess || state is LoginFailure) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              }

              if (state is LoginSuccess) {
                trigSuccess?.change(true);
                await Future.delayed(const Duration(milliseconds: 1500));
                if (!mounted) return;

                final role = state.role;
                if (role == 'ROLE_ADMIN') {
                  context.go('/admin');
                } else if (role == 'ROLE_USUARIO') {
                  context.go('/home');
                } else if (role == 'ROLE_EMPRENDEDOR') {
                  context.go('/emprendedor');
                } else {
                  context.go('/home');
                }
              }

              if (state is LoginFailure) {
                trigFail?.change(true);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${state.error}")),
                );
              }
            },
            child: SingleChildScrollView(
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
                        _buildTextField(
                          context,
                          controller: emailController,
                          focusNode: emailFocusNode,
                          hint: "User Name",
                          onChanged: (v) => numLook?.change(v.length.toDouble()),
                        ),
                        const SizedBox(height: 8),
                        _buildTextField(
                          context,
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          hint: "Password",
                          obscure: !_isPasswordVisible,
                          suffixIcon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                            child: IconButton(
                              key: ValueKey<int>(DateTime.now().millisecondsSinceEpoch), // Forzar redibujado
                              icon: Icon(
                                _isBlinking
                                    ? Icons.remove_red_eye // Ícono intermedio (simula ojo entrecerrado)
                                    : (_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isBlinking = true;
                                });

                                Future.delayed(const Duration(milliseconds: 150), () {
                                  setState(() {
                                    _isBlinking = false;
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 64,
                          child: ElevatedButton(
                            onPressed: () {
                              print("boton presionado");
                              final email = emailController.text.trim();
                              final password = passwordController.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Completa todos los campos")),
                                );
                                return;
                              }

                              context.read<LoginBloc>().add(
                                LoginSubmitted(
                                  username: email,
                                  password: password,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF183454),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text("Login", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.go("/home"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      BuildContext context, {
        required TextEditingController controller,
        required FocusNode focusNode,
        required String hint,
        bool obscure = false,
        void Function(String)? onChanged,
        Widget? suffixIcon,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscure,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          suffixIcon: suffixIcon,
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: onChanged,
      ),
    );
  }
}
