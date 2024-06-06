import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/providers/pending_orders.dart';
import 'package:tsp_route_finder/tsp_route_finder.dart';

final tspIndexesProvider = FutureProvider.autoDispose<List<int>>((ref) async {
  final orders = await ref.read(pendingOrdersProvider.future);
  final List<CitiesLocations> points = [];

  for (final order in orders) {
    points.add(CitiesLocations(
      cityName: order.customerAddress,
      latitude: double.parse(order.userLat),
      longitude: double.parse(order.userLong),
    ));
  }

  final tspRoute = await TspPackage.calculateTspRoute(
    locations: points,
    startingLocationIndex: 0,
  );
  print(tspRoute);
  return tspRoute;
});

// void main() async {
//   // Define a list locations
//   final List<CitiesLocations> locations = [
//     CitiesLocations(
//         cityName: "Cairo",
//         latitude: 30.04536650078621,
//         longitude: 31.233230917179828),
//     CitiesLocations(
//         cityName: "Tanta",
//         latitude: 30.78654967266781,
//         longitude: 31.001245021237708),
//     CitiesLocations(
//         cityName: "Mansoura",
//         latitude: 31.040718440307945,
//         longitude: 31.380351843023824),
//     CitiesLocations(
//         cityName: "Aswan",
//         latitude: 24.089512449946742,
//         longitude: 32.89933393026378),
//     CitiesLocations(
//         cityName: "Alexandria",
//         latitude: 31.200888037065972,
//         longitude: 29.927766526114013),
//   ];

//   // Calculate the TSP route
//   tspRoute = await TspPackage.calculateTspRoute(
//     locations: locations,
//     startingLocationIndex: 0,
//   );

//   print(tspRoute);
// }
