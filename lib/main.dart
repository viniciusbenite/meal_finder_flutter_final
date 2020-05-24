import 'package:flutter/material.dart';
import 'package:mealfinder/login.dart';

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
