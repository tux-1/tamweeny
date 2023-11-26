import 'package:flutter/material.dart';

import '../screens/tamween-info.dart';
import '../generated/l10n.dart';
import '../widgets/login_card.dart';
import '../widgets/custom_scaffold.dart';
import 'signUp-screen.dart';

class LogInScreen extends StatelessWidget {
  static const routeName = '/login-screen';

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

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return CustomScaffold(
      fadeBackground: false,
      body: Container(
        constraints: BoxConstraints(
          maxHeight: deviceSize.height,
          maxWidth: deviceSize.width,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Some spacing from the top
                  SizedBox(height: deviceSize.height * 0.05),
                  Text(
                    S.of(context).welcome,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    S.of(context).welcomeSubtitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  //Spacing between title and login
                  SizedBox(
                    height: deviceSize.height * 0.3,
                  ),
                  Text(
                    S.of(context).logInTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  //The login box until the button
                  LogInCard(
                    deviceSize: deviceSize,
                  ),
                  const SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}
