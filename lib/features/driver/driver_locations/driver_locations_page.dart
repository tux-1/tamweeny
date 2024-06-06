import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:tamweeny/features/driver/driver_locations/tsp_locations.dart';
import 'package:tamweeny/providers/pending_orders.dart';

class DriverLocationsPage extends ConsumerWidget {
  const DriverLocationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(pendingOrdersProvider);
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
        orders.when(
          data: (ordersData) => MarkerLayer(
            markers: List.generate(
              ordersData.length,
              (index) {
                final order = ordersData[index];
                final ordersOrder = ref.read(tspIndexesProvider).value ?? [];
                int orderIndex = -1;
                for (var i in ordersOrder) {
                  if (i == index) {
                    orderIndex = i;
                  }
                }
                return Marker(
                  point: LatLng(
                    double.parse(order.userLat),
                    double.parse(order.userLong),
                  ),
                  child: Badge(
                    label: Text(orderIndex.toString()),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),
          error: (_, __) => const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
        )
      ],
    );
  }
}
