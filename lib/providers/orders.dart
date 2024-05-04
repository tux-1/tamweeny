import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tamweeny/Models/order.dart';
import '../../../utils/token_manager.dart';

final ordersProvider = FutureProvider.autoDispose<List<Order>>((ref) async {
  // Getting the token
  final token = await TokenManager.getToken();

  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/fullorders'),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  final offersData = json.decode(response.body) as List<dynamic>;
  final List<Order> orders = [];

  for (final item in offersData) {
    orders.add(Order.fromJson(item));
    
  }

  return orders;
});
