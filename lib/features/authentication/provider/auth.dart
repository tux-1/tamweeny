import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamweeny/providers/products.dart';

import '../../../models/exceptions.dart';
import '../../../models/user.dart';

import '../../../providers/filters.dart';
import '../../../utils/token_manager.dart';

final authProvider = Provider<Auth>((ref) => Auth(ref));

class Auth {
  ProviderRef ref;

  Auth(this.ref);

  String? _token;
  String? _userId;
  // Timer? _authTimer;
  // DateTime? _expiryDate;

  String get userId {
    return _userId.toString();
  }

  bool get isAuth {
    return _token != null;
  }

  Future<void> logIn(String email, String pass,
      {String device = 'Unknown Device'}) async {
    const String apiUrl = 'http://10.0.2.2:8000/api/login';

    try {
      User userLoginData = User(
        email: email.trim(),
        password: pass.trim(),
        deviceName: "android", // Replace with the actual device name
      );

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept':
              'application/json', // Add this line to specify JSON response
        },
        body: jsonEncode(userLoginData.toJson()),
      );

      final responseData = jsonDecode(response.body);
      final responseToken = responseData['token'];

      if (responseToken == null) {
        throw HttpException(responseData['message']);
      }
      _token = responseToken;
      _userId = responseData['id'].toString();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({'token': _token, 'userId': _userId});
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> register({
    required String email,
    required String pass,
    required String name,
    required String nationalId,
    required DateTime bdate,
    required String cardName,
    required String city,
    required String street,
    required String phone,
    required String cardNumber,
    required String cardNationalId,
    required String cardPassword,
    String device = 'android',
  }) async {
    const String registerApiUrl = 'http://10.0.2.2:8000/api/register';

    User addUser = User(
      email: email.trim(),
      password: pass.trim(),
      deviceName: "android", // Replace with the actual device name
      birthDate: bdate,
      cardName: cardName.trim(),
      cardNationalId: cardNationalId.trim(),
      cardNumber: cardNumber.trim(),
      cardPassword: cardPassword.trim(),
      city: city.trim(),
      name: name.trim(),
      nationalId: nationalId.trim(),
      phoneNumber: phone.trim(),
      street: street.trim(),
    );

    final http.Response response = await http.post(
      Uri.parse(registerApiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(addUser.toJson()),
    );
    if (kDebugMode) {
      print(response.body);
    }
    if (jsonDecode(response.body)['errors'] != null ||
        response.body.contains('error')) {
      if (kDebugMode) {
        print(response.body);
      }
      throw HttpException('Error occured');
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return;
    }
    final extractedData = json.decode(prefs.getString('userData').toString())
        as Map<String, dynamic>;

    _token = extractedData['token'].toString();
    _userId = extractedData['userId'].toString();
  }

  Future<void> logOut() async {
    const String apiUrl = 'http://10.0.2.2:8000/api/logout';

    try {
      await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token', // Include the user's access token
        },
      );
      _token = null;
      _userId = null;
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('userData');
      //prefs.clear(); //is also ok bc we only stored userData

      ref.invalidate(filtersProvider);
      ref.invalidate(asyncProductsProvider);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    // Getting the token
    final token = await TokenManager.getToken();

    final response = await http.delete(
      Uri.parse('http://10.0.2.2:8000/api/deleteAccount'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    if (!response.body.contains('successful')) {
      throw HttpException('Error occured');
    }

    _token = null;
    _userId = null;
    TokenManager.clearToken();
    ref.invalidate(filtersProvider);
    ref.invalidate(asyncProductsProvider);
  }

  Future<void> updateAccountInfo({
    required String name,
    required String phoneNumber,
    required String birthDate,
    required String street,
  }) async {
    // Getting the token
    final token = await TokenManager.getToken();

    final response = await http
        .patch(Uri.parse('http://10.0.2.2:8000/api/updateAccInfo'), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    }, body: {
      'name': name,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate,
      'street': street,
    });

    if (!response.body.contains('successful')) {
      throw HttpException('Error occured');
    }
  }

  // void _autoLogout() {
  //   if (_authTimer != null) {
  //     _authTimer!.cancel();
  //   }
  //   final timeToExpiry = _expiryDate?.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timeToExpiry ?? 0), () {
  //     print('Automatically logged out due to expired token.');
  //     logOut();
  //   });
  // }
}
