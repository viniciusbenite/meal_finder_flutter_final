// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

HasMenuStatus _$HasMenuStatusFromJson(Map<String, dynamic> json) {
  return HasMenuStatus(
    delivery: json['delivery'] as int,
    takeaway: json['takeaway'] as int,
  );
}

Map<String, dynamic> _$HasMenuStatusToJson(HasMenuStatus instance) =>
    <String, dynamic>{
      'delivery': instance.delivery,
      'takeaway': instance.takeaway,
    };

Rest _$RestFromJson(Map<String, dynamic> json) {
  return Rest(
    has_menu_status: (json['has_menu_status'] as List)
        ?.map((e) => e == null
            ? null
            : HasMenuStatus.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RestToJson(Rest instance) => <String, dynamic>{
      'has_menu_status': instance.has_menu_status,
    };

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  return Restaurant(
    R: (json['R'] as List)
        ?.map(
            (e) => e == null ? null : Rest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    res_id: json['res_id'] as int,
    is_grocery_store: json['is_grocery_store'] as bool,
  );
}

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'R': instance.R,
      'res_id': instance.res_id,
      'is_grocery_store': instance.is_grocery_store,
    };

Restaurants _$RestaurantsFromJson(Map<String, dynamic> json) {
  return Restaurants(
    restaurant: json['restaurant'] as Map<String, dynamic>,
    apikey: json['apikey'] as String,
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
      'restaurant': instance.restaurant,
      'apikey': instance.apikey,
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
