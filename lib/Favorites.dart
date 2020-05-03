import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealfinder/RestaurantInfo.dart';

import 'Details.dart';


class Favorites extends StatefulWidget {

  @override
  _FavoritesState createState() => _FavoritesState();

}

class _FavoritesState extends State<Favorites>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
      return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('favorites').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();

          return _buildList(context, snapshot.data.documents);
        },
      );

  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {

    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final restaurantInfo = RestaurantInfo.fromSnapshot(data);

    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(restaurantInfo.name),
          trailing: Text(restaurantInfo.location.locality),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Details(restId: int.parse(restaurantInfo.id))),
            ),
        ),
      ),
    );
  }


}
