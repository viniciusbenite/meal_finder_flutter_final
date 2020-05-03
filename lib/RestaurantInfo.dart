import 'package:cloud_firestore/cloud_firestore.dart';

import 'Location.dart';

class RestaurantInfo{
  final String id;
  final String name;
  final Location location;
  final String thumb;


  RestaurantInfo({this.id, this.name, this.location, this.thumb});
  factory RestaurantInfo.fromJson(Map<String, dynamic> json){
    return RestaurantInfo(
      id: json['id'],
      name: json['name'],
      location: Location.fromJson(json['location']),
      thumb: json['thumb'],
    );
  }



}