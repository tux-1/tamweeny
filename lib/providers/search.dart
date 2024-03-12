import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tamweeny/providers/filters.dart';

import '../utils/token_manager.dart';
import 'product.dart';

final searchProvider = FutureProvider<List<Product>>(
  (ref) async {
    final searchQuery = ref.read(filtersProvider).searchQuery;
    final searchApi = 'http://192.168.1.188:8000/api/productName/$searchQuery';

    final token = await TokenManager.getToken();

    final List<Product> items = [];

    // Getting the products
    final response = await http.get(Uri.parse(searchApi), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    print('here1');
    print(response.body);
    final resultsData = jsonDecode(response.body) as List<dynamic>;
    print('here2');
    for (final result in resultsData) {
      items.add(Product.fromJson(result));
      print(result);
    }

    return items;
  },
);
