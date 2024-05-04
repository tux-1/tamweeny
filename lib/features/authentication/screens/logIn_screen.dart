import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../widgets/login_card.dart';
import '../../../widgets/custom_scaffold.dart';

class LogInScreen extends StatelessWidget {
  static const routeName = '/login-screen';

  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      fadeBackground: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SafeArea(
                  child: Text(
                    S.of(context).welcome,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Text(
                  S.of(context).welcomeSubtitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            
            Column(
              children: [
                Text(
                  S.of(context).logInTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8.5),
                //Login Card + Login Button
                const LogInCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
