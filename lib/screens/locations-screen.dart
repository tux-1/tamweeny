import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/custom_scaffold.dart';

class LocationsScreen extends StatelessWidget {
  static const routeName = '/locations-screen';

  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        bottomNavigationBar: const CustomBottomAppBar(isVisible: true),
        body: FlutterMap(
            options: const MapOptions(
                initialCenter: LatLng(
              30.033333,
              31.233334,
            )),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(markers: [
                // ADD MARKERS HERE ..
                // ..
                // Demo Marker
                Marker(
                    rotate: true,
                    point: const LatLng(30.035658, 31.268681),
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    )),
              ])
            ]));
  }
}
