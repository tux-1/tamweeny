import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tamweeny/models/user.dart';

import 'package:tamweeny/services/api.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  Future<List<User>> futureUsers = api().fetchUsers();

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
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Trigger the logout function when the button is pressed
                    Navigator.pop(context);
                    api().logout();
                  },
                  child: Text('Logout'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      User user = snapshot.data![index];
                      return ListTile(
                        title: Text(user.name! + '  ' + user.email!),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
