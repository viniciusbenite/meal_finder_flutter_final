import 'RestaurantInfo.dart';

class Restaurant {
  Restaurant({this.restaurantInfo});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      restaurantInfo: RestaurantInfo.fromJson(json['restaurant']),
    );
  }

  final RestaurantInfo restaurantInfo;
}
