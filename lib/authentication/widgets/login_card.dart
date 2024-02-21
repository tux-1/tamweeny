import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../screens/navigation_screen.dart';
import '../../generated/l10n.dart';
import '../screens/app_signup_screen.dart';
import '../screens/tamween_info.dart';
import 'textformfield_card.dart';
import '../provider/auth.dart';

class LogInCard extends ConsumerStatefulWidget {
  const LogInCard({
    super.key,
  });

  @override
  ConsumerState<LogInCard> createState() => _LogInCardState();
}

class _LogInCardState extends ConsumerState<LogInCard> {
  // bool? _rememberMe = false;

  var _obscureText = true;
  var _isLoading = false;
  final Map<String, String> _logInData = {
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
    final auth = ref.read(authProvider);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    await auth
        .logIn(
      _logInData['email'].toString(),
      _logInData['password'].toString(),
    )
        .then((value) {
      scaffoldMessenger.showSnackBar(const SnackBar(
        content: Text('Successful Login'),
      ));
      Navigator.of(context).pushReplacementNamed(NavigationScreen.routeName);
    }).onError((error, _) {
      showDialog(
          context: context,
          builder: (ctx) {
            String errorText;
            if (error.toString().contains('timed out')) {
              errorText = 'Request timed out.';
            } else {
              errorText = error.toString();
            }
            return AlertDialog(
              title: Text(errorText),
            );
          });
      return null;
    });
    // Navigator.of(context).pushReplacementNamed(NavigationScreen.routeName);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    var iconButton = IconButton(
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: _obscureText
            ? const Icon(
                Icons.visibility,
                color: Colors.white,
              )
            : const Icon(
                Icons.visibility_off,
                color: Colors.white,
              ));

    return SizedBox(
      width: deviceSize.width * 0.95,
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
              obscureText: _obscureText,
              suffixIcon: iconButton,
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

            // Log in button
            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const LinearProgressIndicator(
                      color: Colors.orange,
                    )
                  : Text(S.of(context).logIn),
            ),

            const SizedBox(height: 10),
            TextButton(
              child: Text(
                S.of(context).forgotPassword,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              onPressed: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).noAccount,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
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
