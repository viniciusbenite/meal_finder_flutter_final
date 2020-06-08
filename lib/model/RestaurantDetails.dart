import 'package:mealfinder/model/UserRating.dart';
import 'package:mealfinder/model/Location.dart';

class RestaurantDetails {
  RestaurantDetails(
      {this.id,
      this.name,
      this.location,
      this.thumb,
      this.timings,
      this.cuisines,
      this.averageCostForTwo,
      this.currency,
      this.userRating});

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) {
    return RestaurantDetails(
      id: json['id'],
      name: json['name'],
      location: Location.fromJson(json['location']),
      userRating: UserRating.fromJson(json['user_rating']),
      thumb: json['thumb'],
      timings: json['timings'],
      cuisines: json['cuisines'],
      averageCostForTwo: json['average_cost_for_two'],
      currency: json['currency'],
    );
  }

  final String id;
  final String name;
  final Location location;
  final String thumb;
  final String timings;
  final String cuisines;
  final UserRating userRating;
  final int averageCostForTwo;
  final String currency;
}
