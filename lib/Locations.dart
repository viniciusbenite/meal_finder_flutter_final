import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'Locations.g.dart';

// **********SE MUDAREM O MODELO, CORRER: flutter pub run build_runner build --delete-conflicting-outputs ***********

@JsonSerializable()
class LatLng {
  LatLng({
    this.latitude,
    this.longitude,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);

  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double latitude;
  final double longitude;
}

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
class Restaurants {
  Restaurants({
    this.id,
    this.name,
    this.url,
    this.location,
  });

  factory Restaurants.fromJson(Map<String, dynamic> json) =>
      _$RestaurantsFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantsToJson(this);

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

Future<Restaurants> getRestaurants() async {
  /// Retrieve the locations of restaurants
  final response = await http.get(
      'https://developers.zomato.com/api/v2.1/search?lat=40.6412&lon=-8.65362',
      headers: {"user-key": "00469c39896ef18cd0fcbe0bf5111171"});
  if (response.statusCode == 200) {
    print(response.statusCode);
    print(json.decode(response.body)); // Response tá ok.
    return Restaurants.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse('https://developers.zomato.com/api/v2.1/'));
  }
}