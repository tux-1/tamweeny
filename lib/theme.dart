import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils/lang.dart';

const Map<int, Color> kColorMap = {
  50: Color.fromRGBO(51, 81, 69, .1),
  100: Color.fromRGBO(51, 81, 69, .2),
  200: Color.fromRGBO(51, 81, 69, .3),
  300: Color.fromRGBO(51, 81, 69, .4),
  400: Color.fromRGBO(51, 81, 69, .5),
  500: Color.fromRGBO(51, 81, 69, .6),
  600: Color.fromRGBO(51, 81, 69, .7),
  700: Color.fromRGBO(51, 81, 69, .8),
  800: Color.fromRGBO(51, 81, 69, .9),
  900: Color.fromRGBO(51, 81, 69, 1),
};

ThemeData themeData(BuildContext context) {
  return ThemeData(
    // Define the accent color used for icons, n stuff
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: const MaterialColor(0x335145, kColorMap),
      accentColor: const Color(0xffDEA568),
      // backgroundColor: const Color(0xFF335145),
    ),

    fontFamily: GoogleFonts.lateef().fontFamily,

    // Define the background color of the app
    scaffoldBackgroundColor: const Color(0xff1E352F),

    dialogBackgroundColor: const Color(0xff1E352F),

    // Define text theme to control the text color
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: Color.fromARGB(187, 158, 158, 158),
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating),
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
        foregroundColor: const MaterialStatePropertyAll(Color(0xffDEA568)),
        backgroundColor: const MaterialStatePropertyAll(Color(0xff335145)),
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
      ),
    ),
    // Define the primary color for the app buttons
    datePickerTheme: DatePickerThemeData(
      headerForegroundColor: Colors.white,
      headerHelpStyle: TextStyle(
        color: Colors.white,
        fontFamily: GoogleFonts.lateef().fontFamily,
      ),
      yearStyle: Language.lateefBlack,
      headerBackgroundColor: Colors.black,
      todayBorder: BorderSide.none,
      todayForegroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.isNotEmpty) {
          return Colors.white;
        }
        return Colors.black;
      }),
      backgroundColor: Colors.blueGrey,
      weekdayStyle: Language.lateefBlack,
      dayStyle: Language.lateefBlack,
    ),
    // primaryColor: const Color(0xFF335145),
    iconTheme: const IconThemeData(
      color: Color(0xffDEA568),
    ),
    checkboxTheme: const CheckboxThemeData(
      side: BorderSide(color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.orange),
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      color: Colors.transparent,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.white,
      titleTextStyle:
          GoogleFonts.lateef().copyWith(fontSize: 26, color: Colors.white),
      leadingAndTrailingTextStyle:
          GoogleFonts.lateef().copyWith(fontSize: 26, color: Colors.white),
    ),
    radioTheme: const RadioThemeData(
      fillColor: MaterialStatePropertyAll(
        Color(0xffDEA568),
      ),
    ),
  );
}
