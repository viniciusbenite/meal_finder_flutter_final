import 'package:cloud_firestore/cloud_firestore.dart';


//TODO add picture
class FoodLog {
  final String logName;
  final String mealName;
  final String mealDate;


  FoodLog({this.logName, this.mealName, this.mealDate});

  factory FoodLog.fromJson(Map<String, dynamic> json){
    return FoodLog(
      logName: json['logName'],
      mealName: json['mealName'],
      mealDate: json['mealDate'],
    );
  }

  factory FoodLog.fromSnapshot(DocumentSnapshot documentSnapshot){
    return FoodLog(
      logName: documentSnapshot.data['logName'],
      mealName: documentSnapshot.data['mealName'],
      mealDate: documentSnapshot.data['mealDate'],
    );
  }

  Map<String, dynamic> toMap() =>
      {
        'logName': logName != null ? logName : 'unknown',
        'mealName': mealName != null ? mealName : 'unknown',
        'mealDate': mealDate != null ? mealDate : 'unknown',

      };
}