import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddItemTestPage extends StatelessWidget {
  AddItemTestPage({super.key});

  final TextEditingController priceController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(label: Text('Name')),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(label: Text('Price')),
            ),
            ElevatedButton(
                onPressed: () {
                  http.post(Uri.parse('YOUR API'), body: {
                    'name': nameController.text,
                    'price': priceController.text,
                  });
                },
                child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}
