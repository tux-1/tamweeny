import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [];

  List<Product> get items {
    return _items;
  }

  final String productsApi = 'http://10.0.2.2:8000/api/products?page=';

  void fetchAndSetProducts(int index) async {
    if (items.isNotEmpty && index == 1) {
      return;
    }
    // Getting the token
    final prefs = await SharedPreferences.getInstance();
    final extractedData = json.decode(prefs.getString('userData').toString())
        as Map<String, dynamic>;
    final token = extractedData['token'].toString();

    // Getting the products using token in header, index appended to the Api
    final response = await http.get(Uri.parse('$productsApi$index'),
        headers: {'Authorization': 'Bearer $token'});

    // Loading the products into my list
    final productsData = jsonDecode(response.body)['data'] as List<dynamic>;

    for (var element in productsData) {
      _items.add(Product.fromJson(element));
    }
    notifyListeners();
  }
}
