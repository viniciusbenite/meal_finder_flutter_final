import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/migue/Documents/work/3ano/2semestre/icm/meal_finder_flutter/lib/widgets/delayed_animation.dart';
import 'package:mealfinder/screens/IntroChooseDiets.dart';
import 'package:mealfinder/screens/home_widget.dart';
import 'file:///C:/Users/migue/Documents/work/3ano/2semestre/icm/meal_finder_flutter/lib/utils/sign_in.dart';
import 'package:mealfinder/values/colors.dart';

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
    _scale = 1 - _controller.value;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // SizedBox(
              //   height: 15.0,
              // ),
              AvatarGlow(
                endRadius: 90,
                duration: Duration(seconds: 2),
                glowColor: kGlowColor,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 2),
                startDelay: Duration(seconds: 1),
                child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: kCircleAvatarBackgroundColor,
                      //TODO: Change logo here
                      child: FlutterLogo(
                        size: 50.0,
                      ),
                      radius: 50.0,
                    )),
              ),
              DelayedAnimation(
                child: Text(
                  'Hi There',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: kTextColor),
                ),
                delay: delayedAmount + 1000,
              ),
              DelayedAnimation(
                child: Text(
                  'This is MealFinder',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: kTextColor),
                ),
                delay: delayedAmount + 2000,
              ),
              SizedBox(
                height: 30.0,
              ),
              DelayedAnimation(
                child: Text(
                  'Your diet friendly restaurant finder',
                  style: TextStyle(fontSize: 20.0, color: kTextColor),
                ),
                delay: delayedAmount + 3000,
              ),
              SizedBox(
                height: 120.0,
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
      ),
    );
  }

  final Widget _signInButton = Container(
    height: 60,
    width: 270,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: kTextColor,
    ),
    child: Center(
      child: Text(
        'Sign in with Google',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: kBackgroundColor,
        ),
      ),
    ),
  );
}
