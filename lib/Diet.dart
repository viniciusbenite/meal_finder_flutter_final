import 'package:cloud_firestore/cloud_firestore.dart';


//TODO add picture
class Diet {
  final String dietName;



  Diet({this.dietName});

  factory Diet.fromJson(Map<String, dynamic> json){
    return Diet(
      dietName: json['dietName'],
    );
  }

  factory Diet.fromSnapshot(DocumentSnapshot documentSnapshot){
    return Diet(
        dietName: documentSnapshot.data['dietName'],

    );
  }

  Map<String, dynamic> toMap() =>
      {
        'dietName': dietName != null ? dietName : 'unknown',

      };
}