import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/providers/filters.dart';

import '../utils/token_manager.dart';

import '../Models/product.dart';

final asyncCategoryItemsProvider =
    AsyncNotifierProvider<AsyncCategoryProducts, List<Product>>(
  AsyncCategoryProducts.new,
);

class AsyncCategoryProducts extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() {
    return Future.value(List<Product>.empty());
  }

  final _categoryApi = 'http://10.0.2.2:8000/api/categories/';

  Future<void> getCategoryProducts(String category) async {
    // ref.invalidateSelf();
    List<Product> items = [];

    // Getting the token
    final token = await TokenManager.getToken();

    final response = await http.get(
      Uri.parse('$_categoryApi$category'),
      headers: {'Authorization': 'Bearer $token'},
    );

    final productsData = jsonDecode(response.body) as List<dynamic>;
    for (var element in productsData) {
      items.add(Product.fromJson(element));
    }
    state = AsyncValue.data(items);
  }

  Future<void> toggleFavoriteStatus(int id) async {
    final category = ref.read(filtersProvider).chosenCategory?.categoryName;
    if (category == null) {
      return;
    }
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      List<Product> items = [];

      // Getting the token
      final token = await TokenManager.getToken();

      final response = await http.get(
        Uri.parse('$_categoryApi$category'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final productsData = jsonDecode(response.body) as List<dynamic>;
      for (var element in productsData) {
        items.add(Product.fromJson(element));
      }

      return items;
    });
  }
}
