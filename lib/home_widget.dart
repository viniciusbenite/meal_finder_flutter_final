import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealfinder/Map.dart';

import './Favorites.dart';
import './Feed.dart';
import './FoodLogs.dart';
import './Profile.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<MyHomePage> {
  int _currentIndex = 0;
  String _title;
  FirebaseAuth auth = FirebaseAuth.instance;
  String username;

  final List<Widget> _children = [
    Feed(),
    FoodLogs(),
    MapView(),
    Favorites(),
    Profile()
  ];

  @override
  initState() {
    _title = 'Meal Finder';
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(_title),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            switch (index) {
              case 0:
                {
                  _title = 'Home';
                }
                break;
              case 1:
                {
                  _title = 'Food Logs';
                }
                break;
              case 2:
                {
                  _title = 'Map View';
                }
                break;
              case 3:
                {
                  _title = 'Favorites';
                }
                break;
              case 4:
                {
                  _title = username;
                }
                break;
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.restaurant_menu),
            title: new Text('Food logs'),
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.map), title: new Text('Map View')),
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite),
            title: new Text('Favorites'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }

  _getCurrentUser() async {
    FirebaseUser currentUser = await auth.currentUser();
    setState(() {
      username = currentUser.displayName.toString();
    });
  }
}
