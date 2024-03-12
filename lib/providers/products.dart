import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../features/profile/providers/favorites.dart';
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
    return getInitialProducts();
  }

  final String _productsApi = 'http://192.168.1.188:8000/api/products?page=';
  int? _totalPages;

  Future<void> getNextProducts(int index) async {
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

  Future<List<Product>> getInitialProducts() async {
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
    for (var element in productsData['products']) {
      items.add(Product.fromJson(element));
    }
    return items;
  }

  Future<void> toggleFavoriteStatus(int id) async {
    const favoriteApi = 'http://192.168.1.188:8000/api/favorite';

    final token = await TokenManager.getToken();

    await http.post(
      Uri.parse('$favoriteApi/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    ).then((response) {
      List<Product> myList = state.value ?? [];

      if (myList.any((element) => element.id == id)) {
        final product = myList.firstWhere(
          (element) => id == element.id,
          orElse: () => Product(
              pointsPrice: -1,
              storeId: -1,
              categoryId: -1,
              productType: -1,
              id: -1,
              productName: '-1',
              sellingPrice: -1,
              productImage: '-1',
              description: '-1',
              stockQuantity: -1,
              favoriteStats: false),
        );
        final productIndex = myList.indexOf(product);

        if (productIndex != -1 && product.id != -1) {
          myList[productIndex] = product.copyWith(
            favoriteStats: !product.favoriteStats,
          );

          state = state.copyWithPrevious(AsyncValue.data(myList));
          ref.invalidate(favoritesProvider);
        }
      } else {
        ref.invalidate(favoritesProvider);
      }
    });
  }
}
