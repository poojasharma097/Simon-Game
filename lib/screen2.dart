import 'package:flutter/material.dart';
import 'package:simon_game/my_flutter_app_icons.dart';
import 'dart:math';
import 'package:flutter/foundation.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  List user = [];
  List system = [];
  bool red = true;
  bool green = true;
  bool yellow = true;
  bool blue = true;
  bool gameOver = false;
  int round = 0;
  bool disableButton = false;

  Future<void> startGame() async {
    while (gameOver == false) {
      await Future.delayed(Duration(milliseconds: 100), () async {
        int n = selectColor();
        system.add(n);
        showSelection(n);
        await Future.delayed(Duration(seconds: system.length + 1), () async {
          if (userSelectionCheck()) {
            setState(() {
              ++round;
            });
          } else {
            int score = round;
            gameOver = true;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => AlertDialog(
                icon: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                    'images/balloon.gif',
                    height: 40,
                    width: 50,
                  ),
                ),
                contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                buttonPadding:
                    EdgeInsets.only(top: 0, bottom: 10, left: 30, right: 30),
                actionsPadding:
                    EdgeInsets.only(top: 0, bottom: 20, left: 30, right: 30),
                alignment: Alignment.center,
                title: Text(
                  'Congratulations',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  'Your score is ' + score.toString() + '.',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                  ),
                  textAlign: TextAlign.center,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        disableButton = false;
                        user.clear();
                        system.clear();
                        round = 0;
                      });
                      Navigator.pop(context, 'Play Again');
                    },
                    child: const Text(
                      'Play Again',
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'NotoSans'),
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      disableButton = false;
                      Navigator.pop(context, 'Exit');
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Exit',
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'NotoSans'),
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            );
            setState(() {
              round = 0;
            });
          }
        });
        user.clear();
      });
    }
    if (user.last != system.last) {
      user.clear();
      system.clear();
    }
  }

  int selectColor() {
    Random random = new Random();
    var n = random.nextInt(4) + 1;
    return n;
  }

  void showSelection(int n) {
    if (n == 1) {
      setState(() {
        red = false;
      });
      Future.delayed(Duration(milliseconds: 600), () {
        setState(() {
          red = true;
        });
      });
    } else if (n == 2) {
      setState(() {
        green = false;
      });
      Future.delayed(Duration(milliseconds: 600), () {
        setState(() {
          green = true;
        });
      });
    } else if (n == 3) {
      setState(() {
        yellow = false;
      });
      Future.delayed(Duration(milliseconds: 600), () {
        setState(() {
          yellow = true;
        });
      });
    } else {
      setState(() {
        blue = false;
      });
      Future.delayed(Duration(milliseconds: 600), () {
        setState(() {
          blue = true;
        });
      });
    }
  }

  Color color1() {
    if (red == true)
      return Colors.red;
    else {
      return Colors.red[200]!;
    }
  }

  Color color2() {
    if (green == true)
      return Colors.green;
    else {
      return Colors.green[200]!;
    }
  }

  Color color3() {
    if (yellow == true)
      return Colors.yellow;
    else {
      return Colors.yellow[200]!;
    }
  }

  Color color4() {
    if (blue == true)
      return Colors.blue;
    else {
      return Colors.blue[200]!;
    }
  }

  bool userSelectionCheck() {
    if (user.length != system.length) {
      return false;
    }
    for (int i = 0; i < user.length; i++) {
      if (user[i] != system[i]) {
        return false;
      }
    }
    return true;
  }

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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    'Score : ',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    round.toString(),
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 60,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    child: Hero(
                      tag: 'iconHero',
                      child: Icon(
                        MyFlutterApp.sdot,
                        size: 90,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: 160,
                        height: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            user.add(1);
                          },
                          child: Text(''),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color1(),
                            side: BorderSide(
                              width: 6,
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 160,
                        height: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            user.add(2);
                          },
                          child: Text(''),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color2(),
                            side: BorderSide(
                              width: 6,
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: 160,
                        height: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            user.add(3);
                          },
                          child: Text(''),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color3(),
                            side: BorderSide(
                              width: 6,
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 160,
                        height: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            user.add(4);
                          },
                          child: Text(''),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color4(),
                            side: BorderSide(
                              width: 6,
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              SizedBox(
                height: 60,
                width: 200,
                child: ElevatedButton(
                  onPressed: disableButton
                      ? null
                      : () {
                          setState(() {
                            disableButton = true;
                            gameOver = false;
                          });
                          startGame();
                        },
                  child: Text(
                    'Start',
                    style: TextStyle(
                        fontSize: 17,
                        color: disableButton ? Colors.black : Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: disableButton
                        ? MaterialStatePropertyAll<Color>(Colors.grey)
                        : MaterialStatePropertyAll<Color>(Colors.black),
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
                height: 50,
              ),
              // SizedBox(
              //   height: 180,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
