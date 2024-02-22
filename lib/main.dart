import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

import 'features/navigation_screen.dart';
import 'features/authentication/screens/app_signup_screen.dart';
import 'features/authentication/screens/tamween_info.dart';
import 'generated/l10n.dart';
import 'features/authentication/screens/splash_body.dart';

import 'features/authentication/screens/logIn_screen.dart';
import 'features/authentication/screens/tamween-signUp_screen.dart';
import 'theme.dart';

void main() {
  runApp(const riverpod.ProviderScope(child: MyApp()));
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
        NavigationScreen.routeName: (ctx) => NavigationScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        TamweenSignUpScreen.routeName: (ctx) => TamweenSignUpScreen(),
        TamweenInfo.routeName: (ctx) => TamweenInfo(),
        LogInScreen.routeName: (ctx) => LogInScreen(),
      },
    );
  }
}
