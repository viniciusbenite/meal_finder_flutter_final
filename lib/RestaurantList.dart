import 'Restaurant.dart';

class RestaurantList {
  final List<Restaurant> restaurants;

  RestaurantList({this.restaurants});

  factory RestaurantList.fromJson(Map<String, dynamic> json) {
    var list = json['restaurants'] as List;

    List<Restaurant> restaurantList=list.map((i) => Restaurant.fromJson(i)).toList();
    print (list);
    return RestaurantList(
      restaurants: restaurantList,

    );
  }
}