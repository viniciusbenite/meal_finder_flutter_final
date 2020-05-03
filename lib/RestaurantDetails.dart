import 'Location.dart';

class RestaurantDetails{
  final String id;
  final String name;
  final Location location;
  final String thumb;
  final String timings;
  final String cuisines;
  final int averageCostForTwo;
  final String currency;

  RestaurantDetails({this.id, this.name, this.location, this.thumb, this.timings,
      this.cuisines, this.averageCostForTwo, this.currency});

  factory RestaurantDetails.fromJson(Map<String, dynamic> json){
    return RestaurantDetails(
      id: json['id'],
      name: json['name'],
      location: Location.fromJson(json['location']),
      thumb: json['thumb'],
      timings: json['timings'],
      cuisines: json['cuisines'],
      averageCostForTwo: json['average_cost_for_two'],
      currency: json['currency'],
    );
  }

  }