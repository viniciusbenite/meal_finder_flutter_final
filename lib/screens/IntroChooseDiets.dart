import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealfinder/model/Diet.dart';
import 'package:mealfinder/screens/home_widget.dart';
import 'package:mealfinder/values/colors.dart';

class IntroChooseDiets extends StatefulWidget {
  @override
  _IntroChooseDietsState createState() => _IntroChooseDietsState();
}

class _IntroChooseDietsState extends State<IntroChooseDiets> {
  List<String> dietList = [];
  bool vegan = false;
  bool vegetarian = false;
  bool paleo = false;
  bool macrobiotic = false;
  String uidStr;
  FirebaseAuth auth = FirebaseAuth.instance;

  Widget _widget(String text) {
    Widget insideWidget;
    switch (text) {
      case 'Vegan':
        insideWidget = RaisedButton(
            onPressed: _buttonVeganChange,
            child: Text(
              'Vegan',
              style: Theme.of(context).textTheme.headline5,
            ));
        break;
      case 'Vegetarian':
        insideWidget = RaisedButton(
            onPressed: _buttonVegetarianChange,
            child: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.headline5,
            ));
        break;
      case 'Paleo':
        insideWidget = RaisedButton(
            onPressed: _buttonPaleoChange,
            child: Text(
              'Paleo',
              style: Theme.of(context).textTheme.headline5,
            ));
        break;
      case 'Macrobiotic':
        insideWidget = RaisedButton(
            onPressed: _buttonMacrobioticChange,
            child: Text(
              'Macrobiotic',
              style: Theme.of(context).textTheme.headline5,
            ));
        break;
      default:
        insideWidget = Container();
        break;
    }
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: insideWidget,
    );
  }

  void _buttonVeganChange() {
    setState(() {
      if (vegan) {
        vegan = false;
        dietList.remove('Vegan');
      } else {
        vegan = true;
        dietList.add('Vegan');
      }
    });
  }

  void _buttonVegetarianChange() {
    setState(() {
      if (vegetarian) {
        vegetarian = false;
        dietList.remove('Vegetarian');
      } else {
        vegetarian = true;
        dietList.add('Vegetarian');
      }
    });
  }

  void _buttonPaleoChange() {
    setState(() {
      if (paleo) {
        paleo = false;
        dietList.remove('Paleo');
      } else {
        paleo = true;
        dietList.add('Paleo');
      }
    });
  }

  void _buttonMacrobioticChange() {
    setState(() {
      if (macrobiotic) {
        macrobiotic = false;
        dietList.remove('Macrobiotic');
      } else {
        macrobiotic = true;
        dietList.add('Macrobiotic');
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
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(crossAxisCount: 2, children: <Widget>[
          _widget('Vegan'),
          _widget('Vegetarian'),
          _widget('Paleo'),
          _widget('Macrobiotic'),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => saveDiets(),
        label: Text('Submit'),
      ),
    );
  }

  Future saveDiets() async {
    try {
      final _favoritesCollectionReference = Firestore.instance
          .collection('users')
          .document(uidStr)
          .collection('diets');
      var diets = <Diet>[];
      for (var s in dietList) {
        diets.add(Diet(dietName: s));
      }
      for (var d in diets) {
        await _favoritesCollectionReference.add(d.toMap());
      }
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  void _getCurrentUser() async {
    var currentUser = await auth.currentUser();
    setState(() {
      uidStr = currentUser.uid;
    });
  }
}
