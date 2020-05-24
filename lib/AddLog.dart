import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealfinder/FoodLog.dart';
import 'package:mealfinder/camera_screen.dart';
import 'package:path/path.dart';

class AddLog extends StatefulWidget {
  @override
  _AddLogState createState() => _AddLogState();
}

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScreen(),
    );
  }
}

class _AddLogState extends State<AddLog> {
  File _image;
  File _picture;
  String uidStr;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  String _selectedDate;

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();


  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    myController1.addListener(_printLatestValue);
    myController2.addListener(_printLatestValue2);
  }
  _printLatestValue() {
    print("First text field: ${myController1.text}");
  }
  _printLatestValue2() {
    print("Second text field: ${myController2.text}");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("New log"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: myController1,
              decoration: new InputDecoration.collapsed(
                  hintText: 'Log Name'

              ),
            ),
            TextField(
              controller: myController2,
              decoration: new InputDecoration.collapsed(
                  hintText: 'Meal Name'
              ),

            ),

            Text(_selectedDate == null ? 'Select a date' : _selectedDate.toString()),
            RaisedButton(
              child: Text('Pick a date'),
              onPressed: (){
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                  lastDate: DateTime(2022),
                ).then((date){
                  setState(() {
                    _selectedDate = date.day.toString() +
                        "/" +
                        date.month.toString() +
                        "/" +
                        date.year.toString();
                  });
                });
              },
            ),
            _image == null
                ? Text('No image selected.')
                : Image.file(
                    _image,
                    width: 200,
                    height: 200,
                  ),
            _picture == null
                ? Text('No picture taken') //TODO inútil agora
                : Image.file(
                    _picture,
                    width: 200,
                    height: 200,
                  ),
            RaisedButton(
              onPressed: getImage,
              child: (Icon(Icons.add_photo_alternate)),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CameraApp(),
                ));
              },
              child: (Icon(Icons.add_a_photo)),
            )
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          onSubmit();
          Navigator.pop(context);
        },
        label: Text("Submit"),
        backgroundColor: Colors.purple,

      ),

    );


  }

  Future onSubmit() async{
    //send food log to firestore

    String fileName = basename(_image.path);
    FirebaseStorage _storage = FirebaseStorage.instance;

    //passing your path with the filename to Firebase Storage Reference
    StorageReference reference =
    _storage.ref().child("images/$fileName");

    //upload the file to Firebase Storage
    StorageUploadTask uploadTask = reference.putFile(_image);

    //Snapshot of the uploading task
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    var downloadUrl = await taskSnapshot.ref.getDownloadURL();

    print (downloadUrl);
    print ("Submitting");
    print (Text(myController1.text).toString() + " " + Text(myController2.text).toString() + " "+_selectedDate.toString() );
    addToLogs(myController1.text.toString(), myController2.text.toString(), _selectedDate.toString(), downloadUrl);

  }

  Future addToLogs(String logName, String mealName, String mealDate, String thumb) async {
    try {

      final CollectionReference _favoritesCollectionReference =
      Firestore.instance.collection("users").document(uidStr).collection('food_logs');
      FoodLog foodLog= new FoodLog(logName: logName, mealName: mealName, mealDate: mealDate, pictureUrl: thumb);
      await _favoritesCollectionReference.add(foodLog.toMap());
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