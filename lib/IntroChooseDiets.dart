import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealfinder/home_widget.dart';

import 'Diet.dart';

class IntroChooseDiets extends StatefulWidget {
  @override
  _IntroChooseDietsState createState() => _IntroChooseDietsState();
}

class _IntroChooseDietsState extends State<IntroChooseDiets> {
  List<String> dietList = new List();
  bool vegan = false;
  bool vegetarian = false;
  bool paleo = false;
  bool macrobiotic = false;
  String uidStr;
  FirebaseAuth auth = FirebaseAuth.instance;

  void _buttonVeganChange() {
    setState(() {
      if (vegan) {
        vegan = false;
        dietList.remove("Vegan");
      } else {
        vegan = true;
        dietList.add("Vegan");
      }
    });
  }

  void _buttonVegetarianChange() {
    setState(() {
      if (vegetarian) {
        vegetarian = false;
        dietList.remove("Vegetarian");
      } else {
        vegetarian = true;
        dietList.add("Vegetarian");
      }
    });
  }

  void _buttonPaleoChange() {
    setState(() {
      if (paleo) {
        paleo = false;
        dietList.remove("Paleo");
      } else {
        paleo = true;
        dietList.add("Paleo");
      }
    });
  }

  void _buttonMacrobioticChange() {
    setState(() {
      if (macrobiotic) {
        macrobiotic = false;
        dietList.remove("Macrobiotic");
      } else {
        macrobiotic = true;
        dietList.add("Macrobiotic");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose your diets"),
      ),
      body: GridView.count(crossAxisCount: 2, children: <Widget>[
        RaisedButton(
            onPressed: _buttonVeganChange,
            child: Text(
              'Vegan',
              style: Theme.of(context).textTheme.headline,
            )),
        RaisedButton(
            onPressed: _buttonVegetarianChange,
            child: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.headline,
            )),
        RaisedButton(
            onPressed: _buttonPaleoChange,
            child: Text(
              'Paleo',
              style: Theme.of(context).textTheme.headline,
            )),
        RaisedButton(
            onPressed: _buttonMacrobioticChange,
            child: Text(
              'Macrobiotic',
              style: Theme.of(context).textTheme.headline,
            )),
      ]),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => saveDiets(), label: Text('Submit')),
    );
  }

  Future saveDiets() async {
    try {
      final CollectionReference _favoritesCollectionReference = Firestore
          .instance
          .collection("users")
          .document(uidStr)
          .collection('diets');
      List<Diet> diets = new List();
      for (String s in dietList) {
        diets.add(new Diet(dietName: s));
      }
      for (Diet d in diets) {
        await _favoritesCollectionReference.add(d.toMap());
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  _getCurrentUser() async {
    FirebaseUser currentUser = await auth.currentUser();
    setState(() {
      uidStr = currentUser.uid;
    });
  }
}
