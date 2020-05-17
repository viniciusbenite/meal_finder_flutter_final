import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealfinder/Diet.dart';
import 'package:mealfinder/sign_in.dart';


class DietsChosen extends StatefulWidget {

  @override
  _DietsChosenState createState() => _DietsChosenState();
}

class _DietsChosenState extends State<DietsChosen> {
  List<Diet> dietsReceived = new List();
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
        title: new Text("Diets Chosen"),
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
      stream: Firestore.instance.collection("users").document(uidStr).collection('diets').snapshots(),
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

  onAddDiet() {
    //show dialog of diets
    List<String> allDiets= ['Vegan', 'Vegetarian', 'Macrobiotic', 'Paleo'];
    List<String> selectedDiets= [];
    List<String> diets = new List();
    List<String> toShow=new List();
    for (Diet d in dietsReceived) {
      diets.add(d.dietName);
    }
    for (String d in allDiets){
      if (!diets.contains(d)){
        toShow.add(d);
      }
    }
    showDialog(
        context: context,
        builder: (context) {
          return _MyDialog(diets: toShow,
          selectedDiets: selectedDiets,
          onSelectedDietsListChanged: (cities) {
            selectedDiets = cities;
            print(selectedDiets);
          });});
    }
  _getCurrentUser () async {
    FirebaseUser currentUser = await auth.currentUser();
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

      final CollectionReference _favoritesCollectionReference =
      Firestore.instance.collection("users").document(uidStr).collection('diets');
      List<Diet> toSend= new List();
      for (String s in diets){
        toSend.add(new Diet(dietName: s));
      }
      for (Diet d in toSend){
        await _favoritesCollectionReference.add(d.toMap());
      }
      return true;
    } catch (e) {
      return e.toString();
    }
  }
  _getCurrentUser () async {
    FirebaseUser currentUser = await auth.currentUser();
    setState(() {
      uidStr = currentUser.uid;
    });
  }

}