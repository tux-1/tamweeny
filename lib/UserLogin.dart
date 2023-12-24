import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tamweeny/UserList.dart';

class UserLogin {
  String email;
  String password;
  String deviceName;
  String? token; // New field to store the user's token

  UserLogin({
    required this.email,
    required this.password,
    required this.deviceName,
    this.token, // Initialize with null
  });

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'device_name': deviceName};
  }

  // Method to store the user's token
  void setToken(String newToken) {
    token = newToken;
  }

  // Method to retrieve the user's token
  String? getToken() {
    return token;
  }
}

class LoginResponse {
  String token;

  LoginResponse({required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(token: json['token']);
  }
}

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    final String apiUrl = 'http://10.0.2.2:8000/api/login';

    final UserLogin userLogin = UserLogin(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      deviceName:
          'your_device_name_here3', // Replace with the actual device name
    );

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userLogin.toJson()),
    );

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
        userLogin.setToken(loginResponse.token);

        String userToken = loginResponse.token;
        print('User Token: $userToken');
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
      notifyListeners();

      print('User Token: $userToken');
    } else {
      // Handle unsuccessful login (display error message, etc.)
      print('Login failed. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                loginUser();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AuthPage(),
  ));
}
