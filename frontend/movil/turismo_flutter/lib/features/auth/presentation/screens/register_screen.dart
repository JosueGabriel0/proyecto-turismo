import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/features/auth/data/models/register_dto.dart';
import 'package:turismo_flutter/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:turismo_flutter/features/auth/presentation/bloc/register/register_event.dart';
import 'package:turismo_flutter/features/auth/presentation/bloc/register/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de pantalla
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/playa.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                // Redirige a /home (si usas go_router)
                context.go('/home'); // o context.go('/home');
              },
            ),
          ),

          // Modal desde abajo con el formulario
          DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.35,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: BlocConsumer<RegisterBloc, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registro exitoso')),
                        );
                        context.go("/home"); // o context.go('/home');
                      } else if (state is RegisterFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Registro',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: _nombresController,
                            decoration: const InputDecoration(
                              labelText: 'Nombres',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                              ),
                              const Text('Recordar'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: state is RegisterLoading
                                ? null
                                : () {
                              final dto = RegisterDto(
                                username: _usernameController.text.trim(),
                                nombres: _nombresController.text.trim(),
                                password: _passwordController.text,
                              );
                              context.read<RegisterBloc>().add(RegisterSubmitted(registerDto: dto));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(50),
                            ),
                            child: state is RegisterLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text('Registrarse'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}