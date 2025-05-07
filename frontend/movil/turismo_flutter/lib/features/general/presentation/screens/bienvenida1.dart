import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:go_router/go_router.dart';

class Bienvenida1 extends StatefulWidget {
  const Bienvenida1({super.key});

  @override
  _Bienvenida1State createState() => _Bienvenida1State();
}

class _Bienvenida1State extends State<Bienvenida1>{
bool _isPressed = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Tesoros locales',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Descubra y apoye a las empresas locales cerca de usted',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Image.asset(
                  'assets/images/imagenBienvenida1.png',
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 32),
                AnimatedButton(
                    height: 70,
                    width: 900,
                    text: 'EXPLORAR',
                    isReverse: _isPressed,
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: _isPressed ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                    transitionType: TransitionType.LEFT_TO_RIGHT,
                    backgroundColor: _isPressed ? Color(0xFF0AA3EF) : Colors.white,
                    borderColor: Colors.black,
                    borderRadius: 0,
                    borderWidth: 2,
                    onPress: (){
                      setState(() {
                        _isPressed = !_isPressed;
                      });
                      context.go('/bienvenida2');
                    }
                    )
              ],
            )
        )
      ),
    );
  }
}