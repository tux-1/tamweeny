import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../utils/token_manager.dart';
import 'location.dart';

final locationsFutureProvider = FutureProvider<List<Location>>((ref) async {
  print('starting..');
  const String locationsApi = 'http://10.0.2.2:8000/api/storesLatLong';
  final List<Location> items = [];

  // Getting the token
  final token = await TokenManager.getToken();

  // Getting the locations using token in header
  final response = await http.get(Uri.parse(locationsApi),
      headers: {'Authorization': 'Bearer $token'});

  // Loading the locations into my list
  final productsData = jsonDecode(response.body) as List<dynamic>;

  for (var element in productsData) {
    items.add(Location.fromJson(element));
  }
  return items;
});
