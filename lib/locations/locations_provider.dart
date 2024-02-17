import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../utils/token_manager.dart';
import 'location.dart';

final locationsProvider = ChangeNotifierProvider((ref) => Locations());

class Locations extends ChangeNotifier {
  final List<Location> _items = [];

  List<Location> get items {
    return _items;
  }

  final String locationsApi = 'http://10.0.2.2:8000/api/storesLatLong';

  void fetchAndSetLocations() async {
    if (items.isNotEmpty) {
      return;
    }
    // Getting the token
    final token = await TokenManager.getToken();

    // Getting the categories using token in header
    final response = await http.get(Uri.parse(locationsApi),
        headers: {'Authorization': 'Bearer $token'});

    // Loading the categories into my list
    final productsData = jsonDecode(response.body) as List<dynamic>;

    for (var element in productsData) {
      _items.add(Location.fromJson(element));
    }
    notifyListeners();
  }
}
