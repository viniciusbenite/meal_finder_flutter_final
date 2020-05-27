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
  final Map<String, Marker> _markers = {};

  double lat;
  double long;
  int counter = 0;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    print('MAP CREATED');
    final data = await locations.getRestaurants();
    setState(() {
      _markers.clear();
      for (final restaurant in data.restaurants) {
        print('YY');
        restaurant.restaurant.forEach((key, value) {
          if (key == 'location') {
            value.forEach((key, value) {
              if (key == 'latitude') {
                print('LATITUDE: $value');
                lat = double.parse(value);
              } else if (key == 'longitude') {
                print('LONGITUDE: $value');
                long = double.parse(value);
              }
              if (lat != null && long != null) {
                // TODO: ñ pode ficar aqui
                print('XX');
                counter++;
                var marker = Marker(
                  markerId: MarkerId(counter.toString()),
                  position: LatLng(lat, long),
                  infoWindow: InfoWindow(
                    title: counter.toString(),
                    snippet: counter.toString(),
                  ),
                );
                _markers[counter.toString()] = marker;
              }
            });
          }
        });
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
            target: const LatLng(0, 0),
            zoom: 2,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
