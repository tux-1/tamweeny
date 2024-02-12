import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';

import 'screens/navigation_screen.dart';
import 'screens/home_page.dart';
import 'authentication/screens/app_signup_screen.dart';
import 'authentication/screens/tamween_info.dart';
import 'generated/l10n.dart';
import 'authentication/screens/splash_body.dart';
import 'authentication/provider/auth.dart';
import 'providers/products.dart';
import 'screens/locations_screen.dart';
import 'authentication/screens/logIn_screen.dart';
import 'screens/profile_screen.dart';
import 'authentication/screens/tamween-signUp_screen.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //     create: (ctx) => Cart(),
        //   ),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        //   ChangeNotifierProxyProvider<Auth, Orders>(
        //     update: (ctx, auth, previousOrders) {
        //       return Orders(
        //         auth.token.toString(),
        //         auth.userId,
        //         previousOrders == null ? [] : previousOrders.orders,
        //       );
        //     },
        //     create: (ctx) => Orders('', '', []),
        //   ),
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        locale: const Locale('ar'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: themeData(context),
        scrollBehavior: ScrollConfiguration.of(context).copyWith(),
        home: const SplashBody(),
        routes: {
          NavigationScreen.routeName: (ctx) => NavigationScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          HomePage.routeName: (ctx) => HomePage(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          TamweenSignUpScreen.routeName: (ctx) => TamweenSignUpScreen(),
          TamweenInfo.routeName: (ctx) => TamweenInfo(),
          LogInScreen.routeName: (ctx) => LogInScreen(),
          LocationsScreen.routeName: (ctx) => LocationsScreen(),
        },
      ),
    );
  }
}
