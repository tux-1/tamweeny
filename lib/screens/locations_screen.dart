import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationsScreen extends StatefulWidget {
  static const routeName = '/locations-screen';

  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  List<LatLng> routePoints = [];
  LatLng? userLocation;

  Widget attributionWidget = const SingleChildScrollView(
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
  );

  Future<Position> _getCurrentLocation() async {
    // Test if location services are enabled.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
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
    final geoLocation = await Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        userLocation = LatLng(geoLocation.latitude, geoLocation.longitude);
      });
    }
    return geoLocation;
  }

  Marker buildTrackableMarker(
    LatLng markerLocation,
  ) {
    var scaffoldMessenger = ScaffoldMessenger.of(context);
    return Marker(
        rotate: true,
        point: markerLocation,
        child: InkWell(
          onTap: () async {
            // ignore: unused_local_variable
            final location = await _getCurrentLocation();
            LatLng startLocation = //3enwan salama
                const LatLng(
              30.094435768097608,
              31.20311443602142,
            );
            // Replace the LatLng above with the one below in production
            // LatLng(location.latitude, location.longitude);

            //Marker location
            final LatLng endLocation = markerLocation;

            //For reference, See:
            //https://project-osrm.org/docs/v5.24.0/api/?language=cURL#general-options

            var url = Uri.parse(
                'http://router.project-osrm.org/route/v1/driving/${startLocation.longitude},${startLocation.latitude};${endLocation.longitude},${endLocation.latitude}?steps=true&annotations=true&geometries=geojson');
            var response = await http.get(url);
            if (jsonDecode(response.body)["code"] != 'Ok') {
              // Means there's no available route
              scaffoldMessenger.hideCurrentSnackBar();
              scaffoldMessenger.showSnackBar(const SnackBar(
                  showCloseIcon: true,
                  duration: Duration(seconds: 1),
                  content: SizedBox(
                      height: 20,
                      child: Wrap(children: [
                        Text(
                          'No available route',
                        )
                      ]))));
              return;
            }
            if (mounted) {
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
                    double.parse(routePoint[0]),
                  ));
                }
              });
            }
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 30,
          ),
        ));
  }

  Marker userLocationMarker() {
    if (userLocation != null) {
      return Marker(
        point: userLocation!,
        child: const Icon(
          Icons.person_pin_circle,
          color: Color(0xff335145),
          size: 35,
        ),
      );
    }
    return const Marker(
        point: LatLng(0, 0),
        child: Icon(
          Icons.abc,
          color: Colors.transparent,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(30.035658, 31.268681),
          initialZoom: 11.5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          PolylineLayer(
            polylineCulling: false,
            polylines: [
              Polyline(
                points: routePoints,
                color: Colors.blueGrey,
                strokeWidth: 7,
              )
            ],
          ),
          attributionWidget,
          MarkerLayer(markers: [
            // DEMO MARKERS:

            // For emulator this location will be at Google HQ
            userLocationMarker(),

            // Random locations in Cairo
            buildTrackableMarker(const LatLng(30.035658, 31.268681)),
            buildTrackableMarker(
                const LatLng(30.094435768097608, 31.20311443602142)),
            buildTrackableMarker(
                const LatLng(30.093710249529067, 31.218426854554092)),
            buildTrackableMarker(
                const LatLng(30.08334314582945, 31.203597825718397)),

            // Random location near Google HQ
            // buildTrackableMarker(const LatLng(37.423490, -122.078074)),
          ])
        ],
      )
    ;
  }
}
