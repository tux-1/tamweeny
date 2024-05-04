import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../Models/cart_item.dart';
import '../utils/token_manager.dart';

final asyncCartProvider =
    AsyncNotifierProvider<AsyncCartProvider, List<CartItem>>(
  AsyncCartProvider.new,
);

class AsyncCartProvider extends AsyncNotifier<List<CartItem>> {
  @override
  Future<List<CartItem>> build() {
    return getCart();
  }

  final _cartApi = 'http://10.0.2.2:8000/api/cart';

  Future<List<CartItem>> getCart() async {
    // Getting the token
    final token = await TokenManager.getToken();

    final List<CartItem> items = [];

    // Getting the cart
    final response = await http.get(Uri.parse(_cartApi), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    final cartData = jsonDecode(response.body) as List<dynamic>;

    for (final cartItem in cartData) {
      items.add(CartItem.fromJson(cartItem));
    }

    return items;
  }

  Future<void> postCartItem({
    required int productId,
    required bool isAdding,
  }) async {
    // Getting the token
    final token = await TokenManager.getToken();

    // Putting productId
    final response = await http.put(
      Uri.parse(
        '$_cartApi/$productId/${isAdding.toString()}',
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (kDebugMode) {
      print(response.body);
    }
    if (response.body.contains('successful')) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        return getCart();
      });
      return;
    }
  }

  Future<void> createOrder() async {
    const createOrderApi = 'http://10.0.2.2:8000/api/createOrder';

    // Getting the token
    final token = await TokenManager.getToken();

    // Doing request
    http.post(Uri.parse(createOrderApi), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    }).then((value) {
      ref.invalidateSelf();
    });
  }
}
