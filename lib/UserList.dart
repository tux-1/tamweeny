import 'dart:convert';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tamweeny/UserLogin.dart' as user_login;

Future<List<User>> fetchUsers() async {
  String token = '1|bWQFTsPNBpHL5BqXC0pJFzHU0hZFm4fZFGJmk7vt22f81538';
// Replace with your actual token

  http.Response response = await http.get(
      Uri.parse(
        'http://10.0.2.2:8000/api/userss?page=2',
      ),
      headers: {
        'Authorization': 'Bearer $token',
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

late Future<List<User>> futureUsers;

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    super.initState();
    // we have the variabale assigned to the intialaiton of state which will hapen before widget build
    futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  User user = snapshot.data![index];
                  return ListTile(
                    title: Text(user.Name + '  ' + user.email),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
