import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/features/driver/driver_landing_view.dart';
import 'package:tamweeny/features/user/locations/locations_screen.dart';
import 'package:tamweeny/providers/locale.dart';

import 'features/user/landing_screen_view.dart';
import 'features/authentication/screens/app_signup_screen.dart';
import 'features/authentication/screens/tamween_info.dart';
import 'features/user/profile/screens/account_information_screen.dart';
import 'features/user/profile/screens/edit_account_screen.dart';
import 'generated/l10n.dart';
import 'features/authentication/screens/splash_body.dart';

import 'features/authentication/screens/logIn_screen.dart';
import 'features/authentication/screens/tamween-signUp_screen.dart';
import 'theme.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
  // WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // prefs.remove('userData');
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: themeData(context),
      locale: Locale(locale.value?? 'ar'),
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
        LandingScreenView.routeName: (ctx) => const LandingScreenView(),
        SignUpScreen.routeName: (ctx) => const SignUpScreen(),
        TamweenSignUpScreen.routeName: (ctx) => const TamweenSignUpScreen(),
        TamweenInfo.routeName: (ctx) => const TamweenInfo(),
        LogInScreen.routeName: (ctx) => const LogInScreen(),
        AccountInfoScreen.routeName: (ctx) => const AccountInfoScreen(),
        EditAccountScreen.routeName: (ctx) => const EditAccountScreen(),
        DriverLandingView.routeName: (ctx) => const DriverLandingView(),
        LocationsScreen.routeName: (ctx) => const LocationsScreen(),
      },
    );
  }
}
