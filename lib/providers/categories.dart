import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Category {
  final int catId;
  final String catName;

  Category({
    required this.catId,
    required this.catName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      catId: json['catId'],
      catName: json['catName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'catId': catId,
      'catName': catName,
    };
  }
}

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
    final prefs = await SharedPreferences.getInstance();
    final extractedData = json.decode(prefs.getString('userData').toString())
        as Map<String, dynamic>;
    final token = extractedData['token'].toString();

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
