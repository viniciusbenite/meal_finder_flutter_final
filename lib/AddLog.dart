import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AddLog extends StatefulWidget {

  @override
  _AddLogState createState() => _AddLogState();

}

class _AddLogState extends State<AddLog>{
  String _selectedDate;

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();


  @override
  void initState() {
    super.initState();

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
                    _selectedDate=date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                  });
                });
              },
            )


          ],
        ),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onSubmit,
        label: Text("Submit"),
        backgroundColor: Colors.purple,

      ),

    );


  }

  void onSubmit(){
    print ("Submitting");
    print (Text(myController1.text).toString() + " " + Text(myController2.text).toString() + " "+_selectedDate.toString() );
  }

}