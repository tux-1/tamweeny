import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../widgets/login_card.dart';
import '../../widgets/custom_scaffold.dart';

class LogInScreen extends StatelessWidget {
  static const routeName = '/login-screen';

  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return CustomScaffold(
      fadeBackground: false,
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: deviceSize.height,
          maxWidth: deviceSize.width,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: deviceSize.height * 0.05,
                width: deviceSize.width,
              ),
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
                height: deviceSize.height * 0.29,
              ),
              Text(
                S.of(context).logInTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              
              //Login Card + Login Button
              const LogInCard(),
            ],
          ),
        ),
      ),
    );
  }
}
