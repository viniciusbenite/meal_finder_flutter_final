import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:mealfinder/IntroChooseDiets.dart';
import 'package:mealfinder/home_widget.dart';
import 'package:mealfinder/sign_in.dart';
import 'package:mealfinder/values/colors.dart';

import '../delayed_animation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  bool firstTime = true;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            AvatarGlow(
              endRadius: 90,
              duration: Duration(seconds: 2),
              glowColor: Colors.white24,
              repeat: true,
              repeatPauseDuration: Duration(seconds: 2),
              startDelay: Duration(seconds: 1),
              child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    //TODO: Change logo here
                    child: FlutterLogo(
                      size: 50.0,
                    ),
                    radius: 50.0,
                  )),
            ),
            DelayedAnimation(
              child: Text(
                "Hi There",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 35.0, color: color),
              ),
              delay: delayedAmount + 1000,
            ),
            DelayedAnimation(
              child: Text(
                "This is MealFinder",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 35.0, color: color),
              ),
              delay: delayedAmount + 2000,
            ),
            SizedBox(
              height: 30.0,
            ),
            DelayedAnimation(
              child: Text(
                "Your diet friendly restaurant finder",
                style: TextStyle(fontSize: 20.0, color: color),
              ),
              delay: delayedAmount + 3000,
            ),
            SizedBox(
              height: 100.0,
            ),
            DelayedAnimation(
              child: GestureDetector(
                child: Transform.scale(
                  scale: _scale,
                  child: _signInButton,
                ),
                onTap: () {
                  signInWithGoogle().whenComplete(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return firstTime == true
                              ? IntroChooseDiets()
                              : MyHomePage();
                        },
                      ),
                    );
                  });
                },
              ),
              delay: delayedAmount + 4000,
            ),
          ],
        ),
      ),
    );
  }

  Widget _signInButton = Container(
    height: 60,
    width: 270,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),
    child: Center(
      child: Text(
        'Sign in with Google',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8185E2),
        ),
      ),
    ),
  );
}
