import 'package:flutter/material.dart';
import 'package:tamweeny/services/api.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardNationalIdController =
      TextEditingController();
  final TextEditingController cardPasswordController = TextEditingController();

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              TextField(
                controller: passwordController2,
                decoration: InputDecoration(labelText: 'Password_confirm'),
                obscureText: false,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: nationalIdController,
                decoration: InputDecoration(labelText: 'National ID'),
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: birthDateController,
                    decoration: InputDecoration(labelText: 'Birth Date'),
                  ),
                ),
              ),
              TextField(
                controller: cardNameController,
                decoration: InputDecoration(labelText: 'Card Name'),
              ),
              TextField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: stateController,
                decoration: InputDecoration(labelText: 'State'),
              ),
              TextField(
                controller: streetController,
                decoration: InputDecoration(labelText: 'Street'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: cardNumberController,
                decoration: InputDecoration(labelText: 'Card Number'),
              ),
              TextField(
                controller: cardNationalIdController,
                decoration: InputDecoration(labelText: 'Card National ID'),
              ),
              TextField(
                controller: cardPasswordController,
                decoration: InputDecoration(labelText: 'Card Password'),
                obscureText: false,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Call your CreateUser function with the provided data
                  api().CreateUser(
                      email: emailController.text,
                      pass: passwordController.text,
                      pass2: passwordController2.text,
                      Name: nameController.text,
                      NaitionalId: nationalIdController.text,
                      bdate: (selectedDate ?? DateTime.now()),
                      cardName: cardNameController.text,
                      City: cityController.text,
                      State: stateController.text,
                      Street: streetController.text,
                      Phone: phoneController.text,
                      CardNumber: cardNumberController.text,
                      CardNationalId: cardNationalIdController.text,
                      CardPassword: cardPasswordController.text);
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegistrationPage(),
  ));
}
