import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tamweeny/Models/User.dart';
import 'package:tamweeny/Models/TokenManager.dart';
import 'package:tamweeny/UserList.dart';
import 'package:tamweeny/services/api.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              obscureText: false,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                api().loginUser(emailController.text, passwordController.text);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserList()));
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
