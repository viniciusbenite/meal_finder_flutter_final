import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  final String locality;

  Location({this.locality});

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      locality: json['locality'],
    );
  }

  toMap() =>
      {
        'locality': locality != null ? locality : 'unknow',
      };


}