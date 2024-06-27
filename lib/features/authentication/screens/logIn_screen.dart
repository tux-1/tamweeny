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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SafeArea(child: SizedBox(height: 15)),
          Text(
            S.of(context).welcome,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            S.of(context).welcomeSubtitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Spacer(flex: 3,),
          Text(
            S.of(context).logInTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 14),
          //Login Card + Login Button
          const LogInCard(),
          const Spacer(),
        ],
      ),
    );
  }
}
