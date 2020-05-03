import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'RestaurantDetails.dart';

Future<RestaurantDetails> fetchRestaurantDetails(int restId) async {
  String url='https://developers.zomato.com/api/v2.1/restaurant?res_id=$restId';
  final response =
  await http.get(url,
      headers: {"user-key": "00469c39896ef18cd0fcbe0bf5111171"});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print ('resposta' +response.body);
    return RestaurantDetails.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load restaurant details');
  }
}
class Details extends StatefulWidget {

  final int restId;

  const Details({Key key, this.restId}) : super(key: key);


  @override
    _DetailsState createState() => _DetailsState();
  }


class _DetailsState extends State<Details>{
  Future<RestaurantDetails> restDetails;

  @override
  void initState() {
    super.initState();
    restDetails = fetchRestaurantDetails(widget.restId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("Details"),
        ),
        body: Center(
            child: FutureBuilder<RestaurantDetails>(
              future: restDetails,
              builder: (context, snapshot){
                if (snapshot.hasData){
                  RestaurantDetails data=snapshot.data;
                  return new Text(data.name+' '+data.location.locality+ ' '+data.timings + ' '+data.averageCostForTwo.toString() + data.currency+' '+data.cuisines);

                }
                else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return CircularProgressIndicator();
              },
            )
        )

    );

  }


}