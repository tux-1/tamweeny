import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/custom_scaffold.dart';

class LocationsScreen extends StatefulWidget {
  static const routeName = '/locations-screen';

  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  List<LatLng> routePoints = [LatLng(30.033333, 31.233334)];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
          const Flexible(
            child: SingleChildScrollView(
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
            Marker(
                rotate: true,
                point: const LatLng(30.035658, 31.268681),
                child: InkWell(
                  onTap: () async {
                    final startLocation = LatLng(30.035658, 31.268681);
                    final endLocation = LatLng(30.033333, 31.233334);
                    var url = Uri.parse(
                        'http://router.project-osrm.org/route/v1/driving/${startLocation.longitude},${startLocation.latitude};${endLocation.longitude},${endLocation.latitude}?steps=true&annotations=true&geometries=geojson');
                    var response = await http.get(url);

                    setState(() {
                      routePoints = [];
                      var router = jsonDecode(response.body)['routes'][0]
                          ['geometry']['coordinates'];
                      for (int i = 0; i < router.length; i++) {
                        var reep = router[i].toString();
                        reep = reep.replaceAll('[', '');
                        reep = reep.replaceAll(']', '');
                        var lat1 = reep.split(',');
                        var long1 = reep.split(",");
                        routePoints.add(LatLng(
                            double.parse(lat1[1]), double.parse(long1[0])));
                      }
                    });
                  },
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                )),
          ])
        ],
      ),
    );
  }
}
