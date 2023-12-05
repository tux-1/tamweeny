
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../generated/l10n.dart';
import '../widgets/textformfield_card.dart';
import '../widgets/custom_scaffold.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/signup-screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _date = TextEditingController();

  //the Map that'll contain the data we'll take from form
  Map<String, String> _signUpData = {
    'email': '',
    'password': '',
  };

  Future<void> register(BuildContext context) async {
    final navigator = Navigator.of(context);
    if (_formKey.currentState?.validate() == false) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                S.of(context).data_entry_error,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          });
    }
    if (_formKey.currentState?.validate() == true) {
      // sign up function that'll send data to backend
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Successful',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          }).then((_) => navigator.pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return CustomScaffold(
        body: Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Container(
        constraints: BoxConstraints(maxHeight: deviceSize.height),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                S.of(context).signUp,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
              const SizedBox(height: 20),
              Text(
                S.of(context).customer_information,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).name,
                icon: Icons.person,
                onSaved: (value) {
                  // _authData['password'] = value.toString();
                },
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                labelText: S.of(context).national_number,
                icon: Icons.contacts_rounded,
                onSaved: (value) {
                  // _authData['password'] = value.toString();
                },
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                labelText: S.of(context).telephone_number,
                icon: Icons.numbers,
                onSaved: (value) {
                  // _authData['password'] = value.toString();
                },
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).city,
                icon: Icons.location_on,
                onSaved: (value) {
                  // _authData['password'] = value.toString();
                },
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).building_number_street_name,
                icon: Icons.location_on,
                onSaved: (value) {
                  // _authData['password'] = value.toString();
                },
              ),
              //BIRTH DATE FIELD
              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                controller: _date,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());
                  if (pickedDate != null) {
                    setState(() {
                      _date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                    });
                  }
                },
                labelText: S.of(context).birth_date,
                readOnly: true,
                icon: Icons.calendar_month_outlined,
                onSaved: (value) {
                  // _authData['password'] = value.toString();
                },
              ),
              const Divider(
                color: Colors.white,
                height: 20,
                thickness: 3,
              ),
              const SizedBox(height: 10),
              Text(
                S.of(context).tamween_card_information,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).name_registered_on_tamween_card,
                icon: Icons.person,
                onSaved: (value) {
                  // _authData['password'] = value.toString();
                },
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).tamween_card_number,
                keyboardType: TextInputType.number,
                icon: Icons.contacts_rounded,
                onSaved: (value) {
                  // _authData['password'] = value.toString();
                },
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).national_number_on_tamween_card,
                keyboardType: TextInputType.number,
                icon: Icons.numbers,
                onSaved: (value) {
                  // _authData['password'] = value.toString();
                },
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).tamween_password,
                icon: Icons.lock,
                onSaved: (value) {
                  // _authData['password'] = value.toString();
                },
              ),
              const Divider(
                color: Colors.white,
                height: 20,
                thickness: 3,
              ),
              const SizedBox(height: 10),
              // EMAIL FIELD
              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).email,
                icon: Icons.email_rounded,
                onSaved: (value) {
                  // _authData['password'] = value.toString();
                },
              ),

              // PASSWORD FIELD
              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).password,
                controller: _password,
                icon: Icons.lock,
                onSaved: (value) {
                  // _authData['password'] = value.toString();
                },
              ),

              // CONFIRM PASSWORD FIELD
              TextFormFieldCard(
                controller: _confirmPassword,
                textInputAction: TextInputAction.done,
                labelText: S.of(context).confirm_password,
                icon: Icons.lock,
                validator: (_) {
                  if (_confirmPassword.text != _password.text) {
                    return S.of(context).passwords_must_match;
                  }
                  return null;
                },
                onSaved: (value) {
                  // _authData['password'] = value.toString();
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    register(context);
                  },
                  child: Text(S.of(context).register)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
  }
}
