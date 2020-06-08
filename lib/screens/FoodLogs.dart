import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mealfinder/screens/AddLog.dart';
import 'package:mealfinder/model/FoodLog.dart';

class FoodLogs extends StatefulWidget {
  @override
  _FoodLogsState createState() => _FoodLogsState();
}

class _FoodLogsState extends State<FoodLogs> {
  String uidStr;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(uidStr)
          .collection('food_logs')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final foodLog = FoodLog.fromSnapshot(data);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(foodLog.logName),
          subtitle: Text(foodLog.mealName),
          trailing: Text(foodLog.mealDate),
          leading: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 100,
              minHeight: 100,
              maxWidth: 200,
              maxHeight: 200,
            ),
            child:
                Image.network(foodLog.pictureUrl.toString(), fit: BoxFit.cover),
          ),
          onTap: () => print('Clicked food log'),
        ),
      ),
    );
  }

  void onAdd() {
    print('NEW LOG');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddLog()),
    );
  }

  void _getCurrentUser() async {
    var currentUser = await auth.currentUser();
    setState(() {
      uidStr = currentUser.uid;
    });
  }
}
