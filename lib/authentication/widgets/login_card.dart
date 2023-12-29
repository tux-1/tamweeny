import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/navigation_screen.dart';
import '../../generated/l10n.dart';
import '../screens/app_signup_screen.dart';
import '../screens/tamween_info.dart';
import 'textformfield_card.dart';
import '../provider/auth.dart';

class LogInCard extends StatefulWidget {
  const LogInCard({
    super.key,
  });

  @override
  State<LogInCard> createState() => _LogInCardState();
}

class _LogInCardState extends State<LogInCard> {
  // bool? _rememberMe = false;
  var _isLoading = false;
  Map<String, String> _logInData = {
    'email': '',
    'password': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey();

  void signUpQuestion(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              S.of(context).ownCard,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed(SignUpScreen.routeName);
                },
                child: Text(S.of(context).yes),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed(TamweenInfo.routeName);
                },
                child: Text(S.of(context).no),
              )
            ],
          );
        });
  }

  Future<void> _submit() async {
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });

    try {
      // Api().loginUser(
      //     _logInData['email'].toString(), _logInData['password'].toString());

      Provider.of<Auth>(context, listen: false).logIn(
        _logInData['email'].toString(),
        _logInData['password'].toString(),
      );

      //Move the pushReplacement into a then() clause of the above action?
      // Navigator.of(context).pushReplacementNamed(NavigationScreen.routeName);
    } catch (error) {
      //error detection
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      width: deviceSize.width * 0.95,
      // height: deviceSize.height * 0.4,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormFieldCard(
              labelText: S.of(context).email,
              icon: Icons.mail,
              onSaved: (value) {
                _logInData['email'] = value.toString();
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),

            TextFormFieldCard(
              obscureText: true,
              labelText: S.of(context).password,
              icon: Icons.lock,
              onSaved: (value) {
                _logInData['password'] = value.toString();
              },
            ),

            //CheckBox
            // Row(
            //   children: [
            //     const SizedBox(width: 5),
            //     Text(
            //       S.of(context).staySignedIn,
            //       style: Theme.of(context).textTheme.bodyLarge,
            //     ),
            //     Checkbox(
            //         fillColor: MaterialStateProperty.resolveWith((states) {
            //           if (states.contains(MaterialState.selected)) {
            //             return const Color(0xffDEA568);
            //           }
            //           return null;
            //         }),
            //         value: _rememberMe,
            //         onChanged: (value) {
            //           setState(() {
            //             _rememberMe = value;
            //           });
            //         }),
            //   ],
            // ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      _submit();
                    },
                    child: Text(
                      S.of(context).logIn,
                    ),
                  ),
            const SizedBox(height: 10),
            TextButton(
              child: Text(
                S.of(context).forgotPassword,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onPressed: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).noAccount),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    signUpQuestion(context);
                  },
                  child: Text(
                    S.of(context).signUp,
                    style: const TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 225, 170, 108)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
