import 'package:flutter/material.dart';
import 'package:mealfinder/Details.dart';
import 'package:mealfinder/IntroChooseDiets.dart';
import 'package:mealfinder/screens/login.dart';
import 'home_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Meal Finder',

      home: LoginPage(),
    );
  }
}