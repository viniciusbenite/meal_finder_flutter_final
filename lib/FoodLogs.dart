import 'package:flutter/material.dart';
import 'AddLog.dart';

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
      body: Center(
          child: new Text("Food logs page")
          ),
        floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
           child: Icon(Icons.add),
           backgroundColor: Colors.blue,
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