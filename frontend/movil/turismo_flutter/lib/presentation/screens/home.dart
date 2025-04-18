import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isClickedLogin = false;
  bool _isClickedSignup = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Screen 3'),
          actions: [
            AnimatedButton(
              text: 'Log in',
              onPress: (){
                  setState(() {
                    _isClickedLogin = !_isClickedLogin;
                  });
                  context.go('/login');
                  },
              textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: _isClickedLogin ? Colors.white : Colors.black
              ),
              backgroundColor: _isClickedLogin ? Colors.grey : Colors.blueAccent,
              borderRadius: 0,
              borderWidth: 2,
              borderColor: Colors.black,
              isReverse: _isClickedLogin,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              width: 85,
              height: 30,
                  ),
            SizedBox(width: 10),
            AnimatedButton(
              text: 'sign up',
              onPress: (){
                  setState(() {
                    _isClickedSignup = !_isClickedSignup;
                  });
                  context.go('/home');
                  },
              textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: _isClickedSignup ? Colors.white : Colors.black
              ),
              backgroundColor: _isClickedSignup ? Colors.grey : Colors.blueAccent,
              borderRadius: 0,
              borderWidth: 2,
              borderColor: Colors.black,
              isReverse: _isClickedSignup,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              width: 85,
              height: 30,),
            SizedBox(width: 10)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home'),
          ],
        ),
      ),
    );
  }
}
