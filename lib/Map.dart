import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mealfinder/Locations.dart' as locations;

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController mapController;
  Position position;
  final LatLng _center = const LatLng(40.6442700, -8.6455400);

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    print("MAP CREATED");
    final restaurants = await locations.getRestaurants();
    setState(() {
      _markers.clear();
      print("ola" + restaurants.toString());
      print(restaurants.url); //TODO Null
      for (final location in restaurants.location) {
        // TODO: restaurants.location. Essa merda dá null
        print(location);
        print(double.parse(location.latitude));
        final marker = Marker(
          markerId: MarkerId(location.locality),
          position: LatLng(double.parse(location.latitude),
              double.parse(location.longitude)),
          infoWindow: InfoWindow(
            title: location.locality,
            snippet: location.address,
          ),
        );
        _markers[location.locality] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: const LatLng(40.64427, -8.64554),
            zoom: 2,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
