import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/RestaurantDetails.dart';

Future<RestaurantDetails> fetchRestaurantDetails(int restId) async {
  var url = 'https://developers.zomato.com/api/v2.1/restaurant?res_id=$restId';
  final response = await http
      .get(url, headers: {'user-key': '00469c39896ef18cd0fcbe0bf5111171'});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print('resposta' + response.body);
    return RestaurantDetails.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load restaurant details');
  }
}

class Details extends StatefulWidget {
  const Details({Key key, this.restId}) : super(key: key);

  final int restId;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Future<RestaurantDetails> restDetails;

  @override
  void initState() {
    super.initState();
    restDetails = fetchRestaurantDetails(widget.restId);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<RestaurantDetails>(
      future: restDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return restDetailsView(data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    ));
  }

  Widget restDetailsView(RestaurantDetails details) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
              foregroundDecoration: BoxDecoration(color: Colors.black26),
              height: 400,
              child: Image.network(details.thumb, fit: BoxFit.cover)),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    details.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.all(32.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: details.userRating != null
                                          ? ((details.userRating
                                                      .aggregate_rating ??
                                                  '') +
                                              '-' +
                                              (details.userRating.votes != null
                                                  ? details.userRating.votes +
                                                      ' votes'
                                                  : ''))
                                          : '',
                                    )
                                  ]),
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                SizedBox(height: 5.0),
                                Text.rich(
                                  TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(
                                      Icons.location_on,
                                      size: 20.0,
                                    )),
                                    TextSpan(
                                      text: details.location.locality,
                                    )
                                  ]),
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                SizedBox(height: 5.0),
                                Text.rich(
                                  TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(
                                      Icons.access_time,
                                      size: 20.0,
                                    )),
                                    TextSpan(
                                      text: details.timings,
                                    )
                                  ]),
                                  style: TextStyle(fontSize: 20.0),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                details.averageCostForTwo.toString() +
                                    details.currency,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                'For two people',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Cuisines'.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 25.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        details.cuisines,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
