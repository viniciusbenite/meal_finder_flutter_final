import 'package:flutter/material.dart';
import 'package:mealfinder/Details.dart';
import 'package:mealfinder/IntroChooseDiets.dart';
import 'home_widget.dart';


void main() => runApp(App());

class App extends StatelessWidget {
  bool firstIme=false;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Meal Finder',

      home:  bool !=true?  MyHomePage() : IntroChooseDiets(),
    );
  }
}