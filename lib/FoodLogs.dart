import 'package:flutter/material.dart';
import 'AddLog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'FoodLog.dart';


class FoodLogs extends StatefulWidget {

  @override
  _FoodLogsState createState() => _FoodLogsState();

}

class _FoodLogsState extends State<FoodLogs> {

  @override
  void initState() {
    super.initState();
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
      stream: Firestore.instance.collection('food_logs').snapshots(),
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
          onTap: () => print ('Clicked food log'),
          ),
        ),
      );
  }
  void onAdd(){
    print ("NEW LOG");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddLog()),
    );

  }
}