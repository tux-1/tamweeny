import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tamweeny/providers/filters.dart';

import '../utils/token_manager.dart';
import '../Models/product.dart';

final searchProvider = FutureProvider.autoDispose<List<Product>>(
  (ref) async {
    final searchQuery = ref.read(filtersProvider).searchQuery;
    final searchApi = 'http://10.0.2.2:8000/api/productName/$searchQuery';

    final token = await TokenManager.getToken();

    final List<Product> items = [];

    // Getting the products
    final response = await http.get(Uri.parse(searchApi), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    final resultsData = jsonDecode(response.body) as List<dynamic>;

    for (final result in resultsData) {
      items.add(Product.fromJson(result));
    }

    return items;
  },
);
