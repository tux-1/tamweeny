import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  // Timer? _authTimer;
  // DateTime? _expiryDate;

  String get userId {
    return _userId.toString();
  }

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (
        // _expiryDate != null &&
        //   _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  // Future<void> _authenticate(
  //     String email, String password, String urlSegment) async {
  //   //const is a compilation time constant, final is a runtime constant
  //   final url = Uri.parse(
  //       //you can put https:// in the Uri.parse() string
  //       'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAV9AosuFzvn1xTqIYWxoP55m-cLeInLro');
  //   //https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode(
  //         {
  //           'email': email,
  //           'password': password,
  //           'returnSecureToken': true,
  //         },
  //       ),
  //     );
  //     final responseData = json.decode(response.body);
  //     if (responseData['error'] != null) {
  //       print('An error occured: ' + responseData['error']['message']);
  //       throw HttpException(
  //           'An error occured: ' + responseData['error']['message']);
  //     }
  //     if (urlSegment == 'signInWithPassword') {
  //       _token = responseData['idToken'];
  //       _userId = responseData['localId'];
  //       // print(_token);
  //       // print(_userId);
  //       _expiryDate = DateTime.now().add(
  //         Duration(
  //           seconds: int.parse(responseData['expiresIn']),
  //         ),
  //       );
  //       _autoLogout();
  //       notifyListeners();
  //       final prefs = await SharedPreferences.getInstance();
  //       final userData = json.encode({
  //         'token': _token,
  //         'userId': _userId,
  //         'expiryDate': _expiryDate?.toIso8601String(),
  //       });
  //       prefs.setString('userData', userData);
  //     }
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  // Future<void> signUp(String email, String password) async {
  //   return _authenticate(email, password, 'signUp');
  // }

  // Future<void> logIn(String email, String password) async {
  //   return _authenticate(email, password, 'signInWithPassword');
  // }

  Future<void> logIn(String email, String pass,
      {String device = 'android'}) async {
    const String apiUrl = 'http://10.0.2.2:8000/api/login';

    User userLoginData = User(
      email: email.trim(),
      password: pass.trim(),
      deviceName: "android", // Replace with the actual device name
    );

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json', // Add this line to specify JSON response
      },
      body: jsonEncode(userLoginData.toJson()),
    );
    // jsonDecode(source);
    print('Response ${response.body}');
    
  }

  Future<void> register({
    required String email,
    required String pass,
    required String pass2,
    required String name,
    required String nationalId,
    required DateTime bdate,
    required String cardName,
    required String city,
    required String state,
    required String street,
    required String phone,
    required String cardNumber,
    required String cardNationalId,
    required String cardPassword,
    String device = 'android',
  }) async {
    const String registerApiUrl = 'http://10.0.2.2:8000/api/register';

    User adduser = User(
      email: email.trim(),
      password: pass.trim(),
      passwordConfirmation: pass2.trim(),
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
      state: state.trim(),
      street: street.trim(),
    );

    final http.Response response = await http.post(
      Uri.parse(registerApiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(adduser.toJson()),
    );
    print(response);
  }

  // Future<bool> tryAutoLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey('userData')) {
  //     return false;
  //   }
  //   final extractedData = json.decode(prefs.getString('userData').toString())
  //       as Map<String, dynamic>;
  //   final expiryDate = DateTime.parse(extractedData['expiryDate']);
  //   if (expiryDate.isBefore(DateTime.now())) {
  //     return false;
  //   }
  //   _token = extractedData['token'];
  //   _userId = extractedData['userId'];
  //   _expiryDate = expiryDate;
  //   notifyListeners();
  //   _autoLogout();
  //   return true;
  // }

  // Future<void> logOut() async {
  //   _token = null;
  //   _userId = null;
  //   _expiryDate = null;
  //   if (_authTimer != null) {
  //     _authTimer!.cancel();
  //     _authTimer = null;
  //   }
  //   notifyListeners();
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.remove('userData');
  //   //prefs.clear(); //is also ok bc we only stored userData
  // }

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
