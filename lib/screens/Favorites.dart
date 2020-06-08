import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealfinder/model/RestaurantInfo.dart';

import 'Details.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  String uidStr;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(uidStr)
          .collection('favorites')
          .snapshots(),
      builder: (context, snapshot) {
        if (uidStr == null) return LinearProgressIndicator();
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children:
          snapshot.map((data) => _buildListItemV2(context, data)).toList(),
    );
  }

  Widget _buildListItemV2(BuildContext context, DocumentSnapshot data) {
    final restaurantInfo = RestaurantInfo.fromSnapshot(data);

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        //Remove favorite here
        
      },
      child: InkWell(
        //onTap go to the details
        onTap: () => onTapped(restaurantInfo.id),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 10.0,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        restaurantInfo.thumb,
                        fit: BoxFit.cover,
                      ),
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
                    restaurantInfo.name,
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
                    restaurantInfo.location.locality,
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
      ),
    );
  }

  void onTapped(String id) {
    print('tapped with id ' + id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Details(restId: int.parse(id))),
    );
  }

  void _getCurrentUser() async {
    var currentUser = await auth.currentUser();
    setState(() {
      uidStr = currentUser.uid;
    });
  }
}
