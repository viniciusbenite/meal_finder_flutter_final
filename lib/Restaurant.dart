import 'RestaurantInfo.dart';

class Restaurant{
  final RestaurantInfo restaurantInfo;

  Restaurant({this.restaurantInfo});

  factory Restaurant.fromJson(Map<String, dynamic> json){


    return Restaurant (
      restaurantInfo: RestaurantInfo.fromJson(json['restaurant']),
    );
  }
}