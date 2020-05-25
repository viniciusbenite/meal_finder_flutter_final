// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) {
  return LatLng(
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

RestLocations _$RestLocationsFromJson(Map<String, dynamic> json) {
  return RestLocations(
    address: json['address'] as String,
    locality: json['locality'] as String,
    city: json['city'] as String,
    city_id: json['city_id'] as int,
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
    zipcode: json['zipcode'] as String,
    country_id: json['country_id'] as int,
    locality_verbose: json['locality_verbose'] as String,
  );
}

Map<String, dynamic> _$RestLocationsToJson(RestLocations instance) =>
    <String, dynamic>{
      'address': instance.address,
      'locality': instance.locality,
      'city': instance.city,
      'city_id': instance.city_id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'zipcode': instance.zipcode,
      'country_id': instance.country_id,
      'locality_verbose': instance.locality_verbose,
    };

Restaurants _$RestaurantsFromJson(Map<String, dynamic> json) {
  return Restaurants(
    id: json['id'] as String,
    name: json['name'] as String,
    url: json['url'] as String,
    location: (json['location'] as List)
        ?.map((e) => e == null
            ? null
            : RestLocations.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RestaurantsToJson(Restaurants instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'location': instance.location,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
    results_found: json['results_found'] as int,
    results_start: json['results_start'] as int,
    results_shown: json['results_shown'] as int,
    restaurants: (json['restaurants'] as List)
        ?.map((e) =>
            e == null ? null : Restaurants.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LocationsToJson(Locations instance) =>
    <String, dynamic>{
      'results_found': instance.results_found,
      'results_start': instance.results_start,
      'results_shown': instance.results_shown,
      'restaurants': instance.restaurants,
    };
