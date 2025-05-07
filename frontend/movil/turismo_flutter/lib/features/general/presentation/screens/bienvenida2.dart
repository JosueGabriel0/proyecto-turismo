import  'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:go_router/go_router.dart';

class Bienvenida2 extends StatefulWidget {
  const Bienvenida2({super.key});

  @override
  _Bienvenida2State createState() => _Bienvenida2State();
}

class _Bienvenida2State extends State<Bienvenida2> {
  bool _isClicked = false;
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () => context.go('/'), icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80.0, 24.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 110, // Ancho del círculo
                height: 110, // Alto del círculo
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey, // Borde plomo
                    width: 2.0,         // Grosor del borde
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.store,        // Ícono dentro del círculo
                    size: 50,
                    color: Colors.black, // Color del ícono (puede ser el que quieras)
                  ),
                ),
              ),
              const SizedBox(
                height: 50),
              const Text(
                  'Descubre lo nuestro',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Descubra lugares únicos y emprendimientos como juegos en el lago, artesania, comida, y mucho más',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 140,
              ),
              AnimatedButton(
                  text: 'EXPLORAR',
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _isClicked ? Colors.white : Colors.black
                  ),
                  backgroundColor: _isClicked ? Colors.white : Color(0xFF00AAFF),
                  borderRadius: 0,
                  borderWidth: 2,
                  borderColor: Colors.black,
                  isReverse: _isClicked,
                  transitionType: TransitionType.LEFT_TO_RIGHT,
                  width: 900,
                  height: 70,
                  onPress: (){
                    setState(() {
                      _isClicked = !_isClicked;
                    });
                    context.go('/home');
                  })
            ],
          ),
        ),
      );
  }
}
