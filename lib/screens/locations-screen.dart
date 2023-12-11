import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/custom_appbar.dart';

class LocationsScreen extends StatefulWidget {
  static const routeName = '/locations-screen';

  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  List<LatLng> routePoints = [LatLng(30.033333, 31.233334)];
  LatLng? userLocation;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var currentPosition = await Geolocator.getCurrentPosition();
    userLocation = LatLng(currentPosition.longitude, currentPosition.latitude);
    return await Geolocator.getCurrentPosition();
  }

  Marker buildTrackableMarker(
    LatLng markerLocation,
    LatLng userLocation,
  ) {
    return Marker(
        rotate: true,
        point: markerLocation,
        child: InkWell(
          onTap: () async {
            //Current location, must be a LatLng
            final LatLng startLocation = userLocation;

            //Marker location
            final LatLng endLocation = markerLocation;

            //For reference, See:
            //https://project-osrm.org/docs/v5.24.0/api/?language=cURL#general-options

            var url = Uri.parse(
                'http://router.project-osrm.org/route/v1/driving/${startLocation.longitude},${startLocation.latitude};${endLocation.longitude},${endLocation.latitude}?steps=true&annotations=true&geometries=geojson');
            var response = await http.get(url);

            setState(() {
              routePoints = [];
              var router = jsonDecode(response.body)['routes'][0]['geometry']
                  ['coordinates'];
              for (int i = 0; i < router.length; i++) {
                var routePointString = router[i].toString();
                routePointString = routePointString.replaceAll('[', '');
                routePointString = routePointString.replaceAll(']', '');
                var routePoint = routePointString.split(',');

                routePoints.add(LatLng(
                    double.parse(routePoint[1]),
                    double.parse(
                      routePoint[0],
                    )));
              }
            });
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 30,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomAppBar(isVisible: true),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: routePoints[0],
          initialZoom: 14,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            child: SimpleAttributionWidget(
              source: Text(
                'OpenStreetMap contributors',
                overflow: TextOverflow.fade,
                softWrap: true,
              ),
              onTap: null,
            ),
          ),
          PolylineLayer(
            polylineCulling: false,
            polylines: [
              Polyline(points: routePoints, color: Colors.blue, strokeWidth: 7)
            ],
          ),
          MarkerLayer(markers: [
            // ADD MARKERS HERE ..
            // ..
            // Demo Marker
            buildTrackableMarker(
                LatLng(30.035658, 31.268681), LatLng(30.033333, 31.233334)),
            
          ])
        ],
      ),
    );
  }
}
