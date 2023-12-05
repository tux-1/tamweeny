import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './screens/landing-page.dart';
import './screens/signUp-screen.dart';
import './screens/tamween-info.dart';
import 'generated/l10n.dart';
import './screens/splash-body.dart';
import 'helpers/lang.dart';
import 'providers/auth.dart';
import 'providers/products.dart';
import 'screens/logIn-screen.dart';
import 'screens/profile-screen.dart';
import 'screens/tamween-signUp-screen.dart';

void main() {
  runApp(MyApp());
}

Map<int, Color> color = {
  50: const Color.fromRGBO(51, 81, 69, .1),
  100: const Color.fromRGBO(51, 81, 69, .2),
  200: const Color.fromRGBO(51, 81, 69, .3),
  300: const Color.fromRGBO(51, 81, 69, .4),
  400: const Color.fromRGBO(51, 81, 69, .5),
  500: const Color.fromRGBO(51, 81, 69, .6),
  600: const Color.fromRGBO(51, 81, 69, .7),
  700: const Color.fromRGBO(51, 81, 69, .8),
  800: const Color.fromRGBO(51, 81, 69, .9),
  900: const Color.fromRGBO(51, 81, 69, 1),
};

MaterialColor colorCustom = MaterialColor(0x335145, color);

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
        ChangeNotifierProxyProvider<Auth, Products>(
          // use auth tokens to load products
          update: (ctx, auth, previousProducts) {
            // print(auth.token); //auth token reaches here
            return Products();
          },
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
        theme: ThemeData(
          fontFamily: GoogleFonts.lateef().fontFamily,
          // Define the background color of the app
          scaffoldBackgroundColor: const Color(0xff1E352F),
          dialogBackgroundColor: const Color(0xff1E352F),
          // Define text theme to control the text color
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
            headlineMedium: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w500,
              height: 0.9,
            ),
            bodyLarge: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w500,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: GoogleFonts.lateef().copyWith(fontSize: 24),
              iconColor: Colors.white,
              foregroundColor: Colors.white,
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                textStyle: GoogleFonts.lateef().copyWith(fontSize: 23),
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(12, 255, 255, 255),
                side: const BorderSide(
                  color: Color.fromARGB(166, 255, 255, 255),
                )),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor:
                  const MaterialStatePropertyAll(Color(0xffDEA568)),
              backgroundColor:
                  const MaterialStatePropertyAll(Color(0xff335145)),
              textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                fontFamily: GoogleFonts.lateef().fontFamily,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              )),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              fixedSize: MaterialStatePropertyAll<Size>(
                  Size(MediaQuery.of(context).size.width * 0.69, 45)),
            ),
          ),
          // Define the primary color for the app buttons
          datePickerTheme: DatePickerThemeData(
            headerHelpStyle: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.lateef().fontFamily,
            ),
            yearStyle: Language.lateefBlack,
            headerBackgroundColor: Colors.black,
            backgroundColor: Colors.teal,
            weekdayStyle: Language.lateefBlack,
            dayStyle: Language.lateefBlack,
          ),
          // primaryColor: const Color(0xFF335145),
          iconTheme: const IconThemeData(
            color: Color(0xffDEA568),
          ),
          // Define the accent color used for icons, n stuff
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: MaterialColor(0x335145, color),
            accentColor: const Color(0xffDEA568),
            // backgroundColor: const Color(0xFF335145),
          ),
          checkboxTheme: const CheckboxThemeData(
            side: BorderSide(color: Colors.white),
          ),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.orange),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
            color: Colors.white,
            actionsIconTheme: IconThemeData(color: Colors.black),
          ),
          listTileTheme: ListTileThemeData(
            iconColor: Colors.white,
            titleTextStyle: GoogleFonts.lateef().copyWith(fontSize: 26),
            leadingAndTrailingTextStyle:
                GoogleFonts.lateef().copyWith(fontSize: 26),
          ),
          radioTheme: const RadioThemeData(
            fillColor: MaterialStatePropertyAll(
              Color(0xffDEA568),
            ),
          ),
        ),
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
            // physics: BouncingScrollPhysics()
            ),
        home: const SplashBody(),
        routes: {
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          LandingPage.routeName: (ctx) => LandingPage(),
          SignUpScreen.routeName: (ctx) => const SignUpScreen(),
          TamweenSignUpScreen.routeName: (ctx) => TamweenSignUpScreen(),
          TamweenInfo.routeName: (ctx) => const TamweenInfo(),
          LogInScreen.routeName: (ctx) => LogInScreen(),
        },
      ),
    );
  }
}
