import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';
import '../../../providers/auth.dart';
import '../widgets/textformfield_card.dart';
import '../../../widgets/custom_scaffold.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/signup-screen';

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  DateTime? _pickedDate;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _birthDay = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nationalNumberController =
      TextEditingController();
  final TextEditingController _telephoneNumberController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _buildingNumberStreetNameController =
      TextEditingController();
  final TextEditingController _nameOnTamweenCardController =
      TextEditingController();
  final TextEditingController _tamweenCardNumberController =
      TextEditingController();
  final TextEditingController _nationalNumberOnTamweenCardController =
      TextEditingController();
  final TextEditingController _tamweenPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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

      ref
          .read(authProvider)
          .register(
            email: _emailController.text,
            bdate: _pickedDate!,
            pass: _password.text,
            cardName: _nameOnTamweenCardController.text,
            cardNationalId: _nationalNumberOnTamweenCardController.text,
            cardNumber: _tamweenCardNumberController.text,
            cardPassword: _tamweenPasswordController.text,
            city: _cityController.text,
            name: _nameController.text,
            street: _buildingNumberStreetNameController.text,
            nationalId: _nationalNumberController.text,
            phone: _telephoneNumberController.text,
          )
          .then((value) async {
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
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Error occured.')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    return CustomScaffold(
        body: Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBar(
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
                controller: _nameController,
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                labelText: S.of(context).national_number,
                icon: Icons.contacts_rounded,
                controller: _nationalNumberController,
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                labelText: S.of(context).telephone_number,
                icon: Icons.numbers,
                maxLength: 11,
                controller: _telephoneNumberController,
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).city,
                icon: Icons.location_on,
                controller: _cityController,
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).building_number_street_name,
                icon: Icons.location_on,
                controller: _buildingNumberStreetNameController,
              ),

              //BIRTH DATE FIELD
              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                controller: _birthDay,
                validator: (p0) {
                  if (_pickedDate == null) return 'No date picked';
                  return null;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());
                  if (pickedDate != null) {
                    _pickedDate = pickedDate;

                    _birthDay.text = DateFormat.yMd('en').format(pickedDate);
                  }
                },
                labelText: S.of(context).birth_date,
                readOnly: true,
                icon: Icons.calendar_month_outlined,
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
                controller: _nameOnTamweenCardController,
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).tamween_card_number,
                keyboardType: TextInputType.number,
                icon: Icons.contacts_rounded,
                controller: _tamweenCardNumberController,
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).national_number_on_tamween_card,
                keyboardType: TextInputType.number,
                icon: Icons.numbers,
                controller: _nationalNumberOnTamweenCardController,
              ),

              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).tamween_password,
                icon: Icons.lock,
                controller: _tamweenPasswordController,
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
                controller: _emailController,
                validator: ValidationBuilder().email().build(),
              ),

              // PASSWORD FIELD
              TextFormFieldCard(
                textInputAction: TextInputAction.next,
                labelText: S.of(context).password,
                controller: _password,
                icon: Icons.lock,
                obscureText: true,
                validator: ValidationBuilder().minLength(8).build(),
              ),

              // CONFIRM PASSWORD FIELD
              TextFormFieldCard(
                obscureText: true,
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
