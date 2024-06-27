import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:tamweeny/features/driver/driver_locations/tsp_locations.dart';
import 'package:tamweeny/features/driver/home/widgets/order_widget.dart';
import 'package:tamweeny/providers/pending_orders.dart';

import '../../../Models/order.dart';

class DriverLocationsPage extends ConsumerStatefulWidget {
  const DriverLocationsPage({super.key});

  @override
  ConsumerState<DriverLocationsPage> createState() =>
      _DriverLocationsPageState();
}

class _DriverLocationsPageState extends ConsumerState<DriverLocationsPage> {
  Order? currentOrder;
  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(pendingOrdersProvider);
    final ordersOrder = ref.watch(tspIndexesProvider).value ?? [];
    return Stack(
      children: [
        FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(30.035658, 31.268681),
            initialZoom: 11.5,
          ),
          children: [
            // CurrentLocationLayer(),
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
                    int orderIndex = -1;
                    for (final i in ordersOrder) {
                      if (i == index) {
                        orderIndex = ordersOrder.indexOf(i);
                      }
                    }
                    return Marker(
                      point: LatLng(
                        double.parse(order.userLat),
                        double.parse(order.userLong),
                      ),
                      child: Badge(
                        label: Text('${orderIndex + 1}'),
                        child: IconButton(
                          icon: const Icon(Icons.location_on),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              currentOrder = order;
                            });
                          },
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
              error: (_, __) => const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
            ),
          ],
        ),
        if (currentOrder != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentOrder = null;
                    });
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: OrderWidget(order: currentOrder!),
                ),
              ],
            ),
          ).animate().slideX(),
      ],
    );
  }
}
