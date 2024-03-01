import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedData = json.decode(prefs.getString('userData').toString())
        as Map<String, dynamic>;
    final token = extractedData['token'].toString();
    return token;
  }
  

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }
}
