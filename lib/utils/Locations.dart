import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:mealfinder/model/Diet.dart';
import 'package:permission_handler/permission_handler.dart';

part 'Locations.g.dart';
// flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class RestLocations {
  RestLocations({
    this.address,
    this.locality,
    this.city,
    this.city_id,
    this.latitude,
    this.longitude,
    this.zipcode,
    this.country_id,
    this.locality_verbose,
  });

  factory RestLocations.fromJson(Map<String, dynamic> json) =>
      _$RestLocationsFromJson(json);

  Map<String, dynamic> toJson() => _$RestLocationsToJson(this);

  final String address;
  final String locality;
  final String city;
  final int city_id;
  final String latitude;
  final String longitude;
  final String zipcode;
  final int country_id;
  final String locality_verbose;
}

@JsonSerializable()
class HasMenuStatus {
  HasMenuStatus({
    this.delivery,
    this.takeaway,
  });

  factory HasMenuStatus.fromJson(Map<String, dynamic> json) =>
      _$HasMenuStatusFromJson(json);

  Map<String, dynamic> toJson() => _$HasMenuStatusToJson(this);

  final int delivery;
  final int takeaway;
}

@JsonSerializable()
class Rest {
  Rest({
    this.has_menu_status,
  });

  factory Rest.fromJson(Map<String, dynamic> json) => _$RestFromJson(json);

  Map<String, dynamic> toJson() => _$RestToJson(this);

  final List<HasMenuStatus> has_menu_status;
}

@JsonSerializable()
class Restaurant {
  Restaurant({
    this.R,
    this.res_id,
    this.is_grocery_store,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  final List<Rest> R;
  final int res_id;
  final bool is_grocery_store;
}

@JsonSerializable()
class Restaurants {
  Restaurants({
    this.restaurant,
    this.apikey,
    this.id,
    this.name,
    this.url,
    this.location,
  });

  factory Restaurants.fromJson(Map<String, dynamic> json) =>
      _$RestaurantsFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantsToJson(this);

  final Map<String, dynamic> restaurant;
  final String apikey;
  final String id;
  final String name;
  final String url;
  final List<RestLocations> location;
}

@JsonSerializable()
class Locations {
  Locations({
    this.results_found,
    this.results_start,
    this.results_shown,
    this.restaurants,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final int results_found;
  final int results_start;
  final int results_shown;
  final List<Restaurants> restaurants;
}

Future<String> _getUserDiets() async {
  var auth = FirebaseAuth.instance;
  var currentUser = await auth.currentUser();
  var querySnapshot = await Firestore.instance
      .collection('users')
      .document(currentUser.uid)
      .collection('diets')
      .getDocuments();
  var keyword = '';
  for (var i = 0; i < querySnapshot.documents.length; i++) {
    var diet = Diet.fromSnapshot(querySnapshot.documents[i]);
    keyword += diet.dietName + " ";
  }

  return keyword;
}

/// get user location
Future<Locations> getRestaurants() async {
  var keyword = await _getUserDiets();
  print('keyword is ' + keyword);
  Position position;
  if (await Permission.locationWhenInUse.request().isGranted) {
    // Either the permission was already granted before or the user just granted it.
    print('requested');
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('latitude' +
        position.latitude.toString() +
        ' ' +
        position.longitude.toString());
  }

  /// Retrieve the locations of restaurants
  if (position != null) {
    var lat = position.latitude;
    var lon = position.longitude;
    final response = await http.get(
        'https://developers.zomato.com/api/v2.1/search?q=' +
            keyword +
            '&?count=10&lat=' +
            lat.toString() +
            '&lon=' +
            lon.toString() +
            '&sort=rating&order=desc',
        headers: {'user-key': '00469c39896ef18cd0fcbe0bf5111171'});
    if (response.statusCode == 200) {
      return Locations.fromJson(json.decode(response.body));
    } else {
      throw HttpException(
          'Unexpected status code ${response.statusCode}:'
          ' ${response.reasonPhrase}',
          uri: Uri.parse('https://developers.zomato.com/api/v2.1/'));
    }
  }
}
