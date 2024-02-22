import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../utils/token_manager.dart';
import 'product.dart';

final asyncProductsProvider =
    AsyncNotifierProvider<AsyncProductsProvider, List<Product>>(
  AsyncProductsProvider.new,
);

class AsyncProductsProvider extends AsyncNotifier<List<Product>> {
  // ignore: prefer_final_fields

  @override
  Future<List<Product>> build() {
    return initializeProducts();
  }

  final String productsApi = 'http://10.0.2.2:8000/api/products?page=';

  Future<void> fetchAndSetProducts(int index) async {
    
    // Getting the token
    final token = await TokenManager.getToken();

    // Getting the products using token in header, index appended to the Api
    final response = await http.get(Uri.parse('$productsApi$index'),
        headers: {'Authorization': 'Bearer $token'});

    // Loading the products into my list
    final productsData = jsonDecode(response.body) as Map<String, dynamic>;

    for (var element in productsData['products']) {
      state.value!.add(Product.fromJson(element));
    }
  }

  Future<List<Product>> initializeProducts() async {
    List<Product> items = [];
    // Getting the token
    final token = await TokenManager.getToken();

    // Getting the products using token in header, index appended to the Api
    final response = await http.get(Uri.parse('${productsApi}1'),
        headers: {'Authorization': 'Bearer $token'});

    // Loading the products into my list
    final productsData = jsonDecode(response.body) as Map<String, dynamic>;

    for (var element in productsData['products']) {
      items.add(Product.fromJson(element));
    }
    return items;
  }
}
