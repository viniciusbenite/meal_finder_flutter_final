import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealfinder/Location.dart';
import 'package:mealfinder/RestaurantInfo.dart';
import 'dart:async';
import 'dart:convert';
import 'RestaurantList.dart';
import 'Restaurant.dart';
import 'package:getflutter/getflutter.dart';
import 'Details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<RestaurantList> fetchRestaurants() async {
  final response =
  await http.get('https://developers.zomato.com/api/v2.1/search?count=10&sort=rating&order=desc',
      headers: {"user-key": "00469c39896ef18cd0fcbe0bf5111171"});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return RestaurantList.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load restaurants');
  }
}

class Feed extends StatefulWidget {

  @override
  _FeedState createState() => _FeedState();

}

class _FeedState extends State<Feed> {
  Future<RestaurantList> restaurantList;
  final databaseReference = Firestore.instance;


  @override
  void initState() {
    super.initState();
    restaurantList = fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<RestaurantList>(
            future: restaurantList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Restaurant> data = snapshot.data.restaurants;
                return restListView(data);
              }
              else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            },
          )
      ),
    );
  }

  ListView restListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return restInfo(
              data[index].restaurantInfo.id, data[index].restaurantInfo.name,
              data[index].restaurantInfo.location.locality,
              data[index].restaurantInfo.thumb);
        });
  }

  ListTile restInfo(String id, String title, String subtitle, String thumb) =>
      ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        trailing: new IconButton(
          icon: new Icon(Icons.favorite_border),
          onPressed: () {
            print("Added to favorites");
            //call firebase to add to favorites
            addToFavorites(id, title, subtitle, thumb);
          },
        ),
        onTap: () => onTapped(id),
      );

  void onTapped(String id) {
    print("tapped with id " + id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Details(restId: int.parse(id))),
    );
  }


    Future addToFavorites(String id, String title, String subtitle,
        String thumb) async {
      try {
        final CollectionReference _favoritesCollectionReference =
        Firestore.instance.collection('favorites');
        RestaurantInfo restaurantInfo= new RestaurantInfo(id: id, name: title, location: new Location(locality: subtitle), thumb: thumb);
        print (restaurantInfo.location);
        await _favoritesCollectionReference.add(restaurantInfo.toMap());
        return true;
      } catch (e) {
        return e.toString();
      }
    }

  }
