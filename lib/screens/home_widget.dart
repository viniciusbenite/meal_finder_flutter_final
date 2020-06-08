import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/migue/Documents/work/3ano/2semestre/icm/meal_finder_flutter/lib/screens/Favorites.dart';
import 'file:///C:/Users/migue/Documents/work/3ano/2semestre/icm/meal_finder_flutter/lib/screens/Feed.dart';
import 'file:///C:/Users/migue/Documents/work/3ano/2semestre/icm/meal_finder_flutter/lib/screens/FoodLogs.dart';
import 'file:///C:/Users/migue/Documents/work/3ano/2semestre/icm/meal_finder_flutter/lib/screens/Map.dart';
import 'file:///C:/Users/migue/Documents/work/3ano/2semestre/icm/meal_finder_flutter/lib/screens/Profile.dart';
import 'package:mealfinder/values/colors.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<MyHomePage> {
  int _currentIndex = 0;
  FirebaseAuth auth = FirebaseAuth.instance;
  String username;

  final List<Widget> _children = [
    Feed(),
    MapView(),
    FoodLogs(),
    Favorites(),
    Profile()
  ];

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            switch (index) {
              case 0:
                break;
              case 1:
                break;
              case 2:
                break;
              case 3:
                break;
              case 4:
                break;
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Map view'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            title: Text('Food logs'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }

  void _getCurrentUser() async {
    var currentUser = await auth.currentUser();
    setState(() {
      username = currentUser.displayName.toString();
    });
  }
}
