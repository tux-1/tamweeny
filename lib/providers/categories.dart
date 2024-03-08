import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;


import '../Models/category.dart';
import '../utils/token_manager.dart';

final categoriesFutureProvider = FutureProvider<List<Category>>((ref) async {
  const String categoriesApi = 'http://10.0.2.2:8000/api/categories';
  List<Category> items = [];
  // Getting the token
  final token = await TokenManager.getToken();

  // Getting the categories using token in header
  final response = await http.get(Uri.parse(categoriesApi),
      headers: {'Authorization': 'Bearer $token'});

  // Loading the categories into my list
  final productsData = jsonDecode(response.body) as List<dynamic>;

  for (var element in productsData) {
    items.add(Category.fromJson(element));
  }
  return items;
});

