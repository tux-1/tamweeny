import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/navigation_screen.dart';
import 'features/authentication/screens/app_signup_screen.dart';
import 'features/authentication/screens/tamween_info.dart';
import 'features/profile/screens/account_information_screen.dart';
import 'features/profile/screens/favorites_screen.dart';
import 'generated/l10n.dart';
import 'features/authentication/screens/splash_body.dart';

import 'features/authentication/screens/logIn_screen.dart';
import 'features/authentication/screens/tamween-signUp_screen.dart';
import 'theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: themeData(context),
      locale: const Locale('ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(),
      home: const SplashBody(),
      routes: {
        NavigationScreen.routeName: (ctx) => const NavigationScreen(),
        SignUpScreen.routeName: (ctx) => const SignUpScreen(),
        TamweenSignUpScreen.routeName: (ctx) => const TamweenSignUpScreen(),
        TamweenInfo.routeName: (ctx) => const TamweenInfo(),
        LogInScreen.routeName: (ctx) => const LogInScreen(),
        AccountInformationScreen.routeName: (ctx) =>
            const AccountInformationScreen(),
        FavoritesScreen.routeName: (ctx) => const FavoritesScreen(),
      },
    );
  }
}
