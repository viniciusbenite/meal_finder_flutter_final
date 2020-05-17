import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealfinder/login.dart';

import 'DietsChosen.dart';
import 'sign_in.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}


class _ProfileState extends State<Profile>{
  String username;
  String photoUrl;
  @override
  void initState() {
    super.initState();
    getCurrentUserName().then((name) {
      username=name;
      print (username);
    });

    getCurrentUserPhotoUrl().then((s) {
      print (s);
      photoUrl=s;

    });



  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Align(
            alignment:Alignment.center,
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          Image.network(photoUrl != null ? photoUrl : Icons.error.toString()),

        const SizedBox(height: 20, width: 30,),

    FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.black)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DietsChosen()),
          );
        print ('Clicked chosen diets');
        },
        child: const Text(
        'Chosen diets',
        style: TextStyle(fontSize: 20)

    ),

    ),

    FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.black)),
    onPressed: () {
      print ('Clicked help');
    },
    child: const Text(
    'Help',
    style: TextStyle(fontSize: 20)
    )),
          FlatButton(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black)),
              onPressed: () {
                print ('Clicked settings');
              },
              child: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 20)
              )),
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
              child: const Text(
                  'Log out',
                  style: TextStyle(fontSize: 20)
              )),
    ]),
    ),
    );
  }

}

