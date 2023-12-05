import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Language {
  static bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }

  static TextStyle lateefBlack = TextStyle(
    color: Colors.black,
    fontFamily: GoogleFonts.lateef().fontFamily,
  );
}
