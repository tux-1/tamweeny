import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/user.dart';
import '../../models/token_manager.dart';

class LoginResponse {
  String token;

  LoginResponse({required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(token: json['token']);
  }
}

class Api {
  // Function to get the stored token
  Future<void> loginUser(String email, String pass,
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
    print('Request Body: ${jsonEncode(userLoginData.toJson())}');

    if (response.statusCode == 302) {
      // If the response is a redirect, follow the redirect URL
      final String redirectUrl = response.headers['location'] ?? '';
      print('Redirecting to: $redirectUrl');

      // Make another request to the redirect URL
      final http.Response redirectResponse =
          await http.get(Uri.parse(redirectUrl));

      if (redirectResponse.statusCode == 200) {
        // Process the successful response after redirect
        final LoginResponse loginResponse = LoginResponse.fromJson(
          {'token': redirectResponse.body},
        );
      } else {
        print(
            'Failed to follow redirect. Status code: ${redirectResponse.statusCode}');
        print('Response body: ${redirectResponse.body}');
      }
    } else if (response.statusCode == 200) {
      // Process the successful response (not a redirect)
      final LoginResponse loginResponse = LoginResponse.fromJson(
        {'token': response.body},
      );
      String userToken = loginResponse.token;
      TokenManager().setToken(userToken);
      print('User Token: $userToken');
    } else {
      // Handle unsuccessful login (display error message, etc.)
      print('Login failed. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> createUser({
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

    try {
      final http.Response response = await http.post(
        Uri.parse(registerApiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(adduser.toJson()),
      );

      if (response.statusCode == 200) {
        print('Registration succeful');
      } else {
        print('Registration failed. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  Future<List<User>> fetchUsers() async {
    print("Ff");
    print(TokenManager().getToken());
    String? token = TokenManager().getToken();
    //String token = '1|bWQFTsPNBpHL5BqXC0pJFzHU0hZFm4fZFGJmk7vt22f81538';
// Replace with your actual token

    http.Response response = await http.get(
        Uri.parse(
          'http://10.0.2.2:8000/api/userss?page=2',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept':
              'application/json', // Add this line to specify JSON response
        }
        //assinged variable respne to the url and type of vairable is http.repsonse
        );

    List users = jsonDecode(response.body);
    // we decoded reponse body into the list of categories

    //now transfer the list i got from response.body to the list of model <Category>
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return users.map((user) => User.fromJson(user)).toList();
    //so by the end of transfrom we get list of Category Model and return it as a future
  }

  Future<void> logout() async {
    final String apiUrl = 'http://10.0.2.2:8000/api/logout';
    String? token = TokenManager().getToken();

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include the user's access token
      },
    );

    if (response.statusCode == 200) {
      print('Logged out successfully');
      // Handle UI changes or navigation after logout
    } else {
      print('Logout failed. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Handle error
    }
  }
}
