import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealfinder/login.dart';

import 'DietsChosen.dart';
import 'sign_in.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username;
  String photoUrl;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Image.network(photoUrl != null ? photoUrl : Icons.error.toString()),
          const SizedBox(
            height: 20,
            width: 30,
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.black)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DietsChosen()),
              );
              print('Clicked chosen diets');
            },
            child: const Text('Chosen diets', style: TextStyle(fontSize: 20)),
          ),
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black)),
              onPressed: () {
                print('Clicked help');
              },
              child: const Text('Help', style: TextStyle(fontSize: 20))),
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black)),
              onPressed: () {
                print('Clicked settings');
              },
              child: const Text('Settings', style: TextStyle(fontSize: 20))),
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black)),
              onPressed: () {
                signOutGoogle();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Log out', style: TextStyle(fontSize: 20))),
        ]),
      ),
    );
  }

  _getCurrentUser() async {
    FirebaseUser currentUser = await auth.currentUser();
    setState(() {
      username = currentUser.displayName.toString();
      photoUrl = currentUser.photoUrl.toString();
    });
  }
}
