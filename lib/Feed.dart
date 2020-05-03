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
          return restInfoV2(
              data[index].restaurantInfo.id, data[index].restaurantInfo.name,
              data[index].restaurantInfo.location.locality,
              data[index].restaurantInfo.thumb);
        });
  }
  InkWell restInfoV2(String id, String title, String subtitle, String thumb){
    return new InkWell(
      //onTap go to the details
        onTap: () => onTapped(id),
      child:
        Card(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15.0)),
      elevation: 10.0,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/6,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    thumb,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          color: Colors.red,
                          icon: new Icon(Icons.favorite_border),
                          onPressed: () {
                            print("Added to favorites");
                            //call firebase to add to favorites
                            addToFavorites(id, title, subtitle, thumb);
                          },
                        ),
                      ],
                    ),
                  ),
            ],
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
        ],
      ),
    ),
    );
  }

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