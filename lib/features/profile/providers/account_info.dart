import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../utils/token_manager.dart';

final accountInfoProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  // Getting the token
  final token = await TokenManager.getToken();

  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/userData'),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );
  final userData = json.decode(response.body) as Map<String, dynamic>;
  
  return userData;
});
