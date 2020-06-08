import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mealfinder/model/Diet.dart';

class DietsChosen extends StatefulWidget {
  @override
  _DietsChosenState createState() => _DietsChosenState();
}

class _DietsChosenState extends State<DietsChosen> {
  List<Diet> dietsReceived = [];
  bool _isChecked = false;
  String uidStr;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diets Chosen'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddDiet,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("users")
          .document(uidStr)
          .collection('diets')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildDiets(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildDiets(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildDietItem(context, data)).toList(),
    );
  }

  Widget _buildDietItem(BuildContext context, DocumentSnapshot data) {
    final diet = Diet.fromSnapshot(data);
    dietsReceived.add(diet);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(diet.dietName),
        ),
      ),
    );
  }

  void onAddDiet() {
    //show dialog of diets
    var allDiets = <String>['Vegan', 'Vegetarian', 'Macrobiotic', 'Paleo'];
    var selectedDiets = <String>[];
    var diets = <String>[];
    var toShow = <String>[];
    for (var d in dietsReceived) {
      diets.add(d.dietName);
    }
    for (var d in allDiets) {
      if (!diets.contains(d)) {
        toShow.add(d);
      }
    }
    showDialog(
        context: context,
        builder: (context) {
          return _MyDialog(
              diets: toShow,
              selectedDiets: selectedDiets,
              onSelectedDietsListChanged: (cities) {
                selectedDiets = cities;
                print(selectedDiets);
              });
        });
  }

  void _getCurrentUser() async {
    var currentUser = await auth.currentUser();
    print('Hello ' + currentUser.displayName.toString());
    setState(() {
      uidStr = currentUser.uid;
    });
  }
}

class _MyDialog extends StatefulWidget {
  _MyDialog({this.diets, this.selectedDiets, this.onSelectedDietsListChanged});

  final List<String> diets;
  final List<String> selectedDiets;
  final ValueChanged<List<String>> onSelectedDietsListChanged;

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialog> {
  String uidStr;
  List<String> _tempSelectedDiets = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    _tempSelectedDiets = widget.selectedDiets;
    super.initState();
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: widget.diets.length,
                itemBuilder: (BuildContext context, int index) {
                  final dietName = widget.diets[index];
                  return Container(
                    child: CheckboxListTile(
                        title: Text(dietName),
                        value: _tempSelectedDiets.contains(dietName),
                        onChanged: (bool value) {
                          if (value) {
                            if (!_tempSelectedDiets.contains(dietName)) {
                              setState(() {
                                _tempSelectedDiets.add(dietName);
                              });
                            }
                          } else {
                            if (_tempSelectedDiets.contains(dietName)) {
                              setState(() {
                                _tempSelectedDiets.removeWhere(
                                    (String diet) => diet == dietName);
                              });
                            }
                          }
                          widget.onSelectedDietsListChanged(_tempSelectedDiets);
                        }),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.purple,
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  saveDiets(_tempSelectedDiets);
                  Navigator.pop(context);
                },
                color: Colors.purple,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future saveDiets(List<String> diets) async {
    try {
      final _favoritesCollectionReference = Firestore.instance
          .collection('users')
          .document(uidStr)
          .collection('diets');
      var toSend = <Diet>[];
      for (var s in diets) {
        toSend.add(Diet(dietName: s));
      }
      for (var d in toSend) {
        await _favoritesCollectionReference.add(d.toMap());
      }
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
