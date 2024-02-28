import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../utils/token_manager.dart';
import 'filters.dart';
import 'product.dart';

final asyncProductsProvider =
    AsyncNotifierProvider<AsyncProductsProvider, List<Product>>(
  AsyncProductsProvider.new,
);

class AsyncProductsProvider extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() {
    return fetchInitialProducts();
  }

  final String _productsApi = 'http://10.0.2.2:8000/api/products?page=';
  int? _totalPages;

  Future<void> addProducts(int index) async {
    if (_totalPages != null && index > _totalPages!) {
      return;
    }
    // Getting the token
    final token = await TokenManager.getToken();

    // Getting the products using token in header, index appended to the Api
    final response = await http.get(Uri.parse('$_productsApi$index'),
        headers: {'Authorization': 'Bearer $token'});

    // Loading the products into my list
    final productsData = jsonDecode(response.body) as Map<String, dynamic>;
    _totalPages = jsonDecode(response.body)['totalPages'];

    for (var element in productsData['products']) {
      state.value!.add(Product.fromJson(element));
    }
    ref.read(filtersProvider).mostPopularPaginationIndex++;
  }

  Future<List<Product>> fetchInitialProducts() async {
    List<Product> items = [];

    // Getting the token
    final token = await TokenManager.getToken();

    // Getting the products using token in header, index appended to the Api
    final response = await http.get(
      Uri.parse('${_productsApi}1'),
      headers: {'Authorization': 'Bearer $token'},
    );

    // Loading the products into my list
    final productsData = jsonDecode(response.body) as Map<String, dynamic>;
    // final response2 = await http.get(
    //   Uri.parse('http://10.0.2.2:8000/api/favorites'),
    //   headers: {
    //     'Authorization': 'Bearer $token',
    //     'Accept': 'application/json',
    //   },
    // );
    // print(response2.body);
    for (var element in productsData['products']) {
      items.add(Product.fromJson(element));
    }
    return items;
  }

  Future<void> editFavoriteStatus(int id) async {
    const favoriteApi = 'http://10.0.2.2:8000/api/favorite';

    final token = await TokenManager.getToken();

    await http.post(
      Uri.parse('$favoriteApi/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    ).then((response) {
      List<Product> myList = state.value ?? [];
      final product = myList.firstWhere((element) => id == element.id);
      final productIndex = myList.indexOf(product);
      myList[productIndex] =
          product.copyWith(favoriteStats: !product.favoriteStats);

      state = state.copyWithPrevious(AsyncValue.data(myList));
    });
  }
}
