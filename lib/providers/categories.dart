import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../Models/category.dart';
import '../utils/token_manager.dart';



class CategoriesProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Category> _items = [];

  List<Category> get items {
    return _items;
  }

  final String categoriesApi = 'http://10.0.2.2:8000/api/categories';

  void fetchAndSetCategories() async {
    if (items.isNotEmpty) {
      return;
    }
    // Getting the token
    final token = await TokenManager.getToken();

    // Getting the categories using token in header
    final response = await http.get(Uri.parse(categoriesApi),
        headers: {'Authorization': 'Bearer $token'});

    // Loading the categories into my list
    final productsData = jsonDecode(response.body) as List<dynamic>;

    for (var element in productsData) {
      _items.add(Category.fromJson(element));
    }
    notifyListeners();
  }
}
