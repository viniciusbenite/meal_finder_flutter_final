import 'Restaurant.dart';

class RestaurantList {
  RestaurantList({this.restaurants});

  factory RestaurantList.fromJson(Map<String, dynamic> json) {
    var list = json['restaurants'] as List;

    var restaurantList = list.map((i) => Restaurant.fromJson(i)).toList();
    print(list);
    return RestaurantList(
      restaurants: restaurantList,
    );
  }

  final List<Restaurant> restaurants;
}
