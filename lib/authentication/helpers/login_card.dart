import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../screens/landing_page.dart';
import '../../widgets/textformfield_card.dart';

class LogInCard extends StatefulWidget {
  LogInCard({
    super.key,
  });

  @override
  State<LogInCard> createState() => _LogInCardState();
}

class _LogInCardState extends State<LogInCard> {
  bool? _rememberMe = false;
  var _isLoading = false;
  Map<String, String> _logInData = {
    'email': '',
    'password': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _submit() async {
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });

    try {
      // login logic
      // await Provider.of<Auth>(context)
      // .logIn(_authData['email'].toString(), _authData['password'].toString());
      Navigator.of(context).pushReplacementNamed(LandingPage.routeName);
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
      child: Form(
        key: _formKey,
        child: Column(
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
            //                                    INSERT PASSWORD RECIEVER
            TextFormFieldCard(
              obscureText: true,
              labelText: S.of(context).password,
              icon: Icons.lock,
              onSaved: (value) {
                _logInData['password'] = value.toString();
              },
            ),
            Row(
              children: [
                const SizedBox(width: 5),
                Text(
                  S.of(context).staySignedIn,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Checkbox(
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return const Color(0xffDEA568);
                      }
                      return null;
                    }),
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value;
                      });
                    }),
              ],
            ),
            const SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}
