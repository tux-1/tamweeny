import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/providers/pending_orders.dart';
import 'package:tsp_route_finder/tsp_route_finder.dart';

final tspIndexesProvider = FutureProvider.autoDispose<List<int>>((ref) async {
  final orders = await ref.read(pendingOrdersProvider.future);
  final List<CitiesLocations> points = [];
  final List<int> tspRoute = [];
  for (final order in orders) {
    points.add(CitiesLocations(
      cityName: order.customerAddress,
      latitude: double.parse(order.userLat),
      longitude: double.parse(order.userLong),
    ));
  }

  if (points.isNotEmpty) {
    final routePoints = await TspPackage.calculateTspRoute(
      locations: points,
      startingLocationIndex: 0,
    );
    for (final point in routePoints) {
      tspRoute.add(point);
    }
  }

  return tspRoute;
});
