import 'package:cloud_firestore/cloud_firestore.dart';


//TODO add picture
class FoodLog {
  final String logName;
  final String mealName;
  final String mealDate;
  final String pictureUrl;


  FoodLog({this.logName, this.mealName, this.mealDate, this.pictureUrl});

  factory FoodLog.fromJson(Map<String, dynamic> json){
    return FoodLog(
      logName: json['logName'],
      mealName: json['mealName'],
      mealDate: json['mealDate'],
      pictureUrl: json['pictureUrl'],
    );
  }

  factory FoodLog.fromSnapshot(DocumentSnapshot documentSnapshot){
    return FoodLog(
      logName: documentSnapshot.data['logName'],
      mealName: documentSnapshot.data['mealName'],
      mealDate: documentSnapshot.data['mealDate'],
        pictureUrl: documentSnapshot.data['pictureUrl']
    );
  }

  Map<String, dynamic> toMap() =>
      {
        'logName': logName != null ? logName : 'unknown',
        'mealName': mealName != null ? mealName : 'unknown',
        'mealDate': mealDate != null ? mealDate : 'unknown',
        'pictureUrl': pictureUrl !=null ? pictureUrl : 'unknown',

      };
}