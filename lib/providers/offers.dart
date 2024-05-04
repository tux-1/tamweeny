import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../Models/product.dart';
import '../../../utils/token_manager.dart';

final offersProvider = FutureProvider.autoDispose<List<Product>>((ref) async {
  // Getting the token
  final token = await TokenManager.getToken();

  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/offers'),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );
  final offersData = json.decode(response.body) as List<dynamic>;
  final List<Product> items = [];

  for (final item in offersData) {
    items.add(Product.fromJson(item));
  }

  return items;
});
