import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealfinder/screens/login.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Finder',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        )
      ),
      home: LoginPage(),
    );
  }
}
