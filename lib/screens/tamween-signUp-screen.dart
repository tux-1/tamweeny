import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../widgets/custom_scaffold.dart';

class TamweenSignUpScreen extends StatefulWidget {
  const TamweenSignUpScreen({super.key});
  static const routeName = "/tamween-signup";

  @override
  State<TamweenSignUpScreen> createState() => _TamweenSignUpScreenState();
}

class _TamweenSignUpScreenState extends State<TamweenSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Form(
          // key:
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text(S.of(context).name),
                CustomTextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1)),
      ),
    );
  }
}
