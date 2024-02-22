import 'package:flutter/material.dart';

import 'features/authentication/services/api.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

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
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: false,
              ),
              TextField(
                controller: passwordController2,
                decoration: const InputDecoration(labelText: 'Password_confirm'),
                obscureText: false,
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: nationalIdController,
                decoration: const InputDecoration(labelText: 'National ID'),
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: birthDateController,
                    decoration: const InputDecoration(labelText: 'Birth Date'),
                  ),
                ),
              ),
              TextField(
                controller: cardNameController,
                decoration: const InputDecoration(labelText: 'Card Name'),
              ),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: stateController,
                decoration: const InputDecoration(labelText: 'State'),
              ),
              TextField(
                controller: streetController,
                decoration: const InputDecoration(labelText: 'Street'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: cardNumberController,
                decoration: const InputDecoration(labelText: 'Card Number'),
              ),
              TextField(
                controller: cardNationalIdController,
                decoration: const InputDecoration(labelText: 'Card National ID'),
              ),
              TextField(
                controller: cardPasswordController,
                decoration: const InputDecoration(labelText: 'Card Password'),
                obscureText: false,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Call your CreateUser function with the provided data
                  Api().createUser(
                      email: emailController.text,
                      pass: passwordController.text,
                      pass2: passwordController2.text,
                      name: nameController.text,
                      nationalId: nationalIdController.text,
                      bdate: (selectedDate ?? DateTime.now()),
                      cardName: cardNameController.text,
                      city: cityController.text,
                      state: stateController.text,
                      street: streetController.text,
                      phone: phoneController.text,
                      cardNumber: cardNumberController.text,
                      cardNationalId: cardNationalIdController.text,
                      cardPassword: cardPasswordController.text);
                },
                child: const Text('Register'),
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
