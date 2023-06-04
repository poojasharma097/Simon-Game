import 'package:flutter/material.dart';
import 'package:simon_game/screen2.dart';
import 'package:simon_game/my_flutter_app_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SimonGame(),
    );
  }
}

class SimonGame extends StatefulWidget {
  const SimonGame({Key? key}) : super(key: key);

  @override
  State<SimonGame> createState() => _SimonGameState();
}

class _SimonGameState extends State<SimonGame> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFFF9DCD8), Color(0xFFDCD8E7)],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Welcome to \nSimon Game',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                child: Hero(
                  tag: 'iconHero',
                  child: Icon(
                    MyFlutterApp.sdot,
                    size: 90,
                  ),
                  // child: Image.asset(
                  //   'images/keyboard.gif',
                  //   height: 250,
                  //   width: 300,
                  // ),
                ),
              ),
              Spacer(),
              SizedBox(
                height: 60,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(_createRoute());
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(fontSize: 17),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                        // side: BorderSide(color: Colors.red)
                      ),
                    ),
                    padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Game(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
