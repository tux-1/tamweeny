import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../../Models/history_order.dart';
import '../../../../utils/token_manager.dart';

final ordersHistoryProvider = FutureProvider.autoDispose<List<HistoryOrder>>(
  (ref) async {
    final List<HistoryOrder> items = [];

    // Getting the token
    final token = await TokenManager.getToken();

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/orders'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    final historyData = jsonDecode(response.body) as List<dynamic>;

    for (final item in historyData) {
      items.add(HistoryOrder.fromJson(item));
    }

    return items;
  },
);
