import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Palette {
  static const Color secondary = Color(0xff3b3dbf);
  static const Color primary = Color(0xff7fc3dc);
  static ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.workSans().fontFamily,
    scaffoldBackgroundColor: const Color(0xfff0f1f5),
    buttonTheme: const ButtonThemeData(buttonColor: secondary),
    inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(), focusColor: primary),
    primaryColor: const Color(0xff7fc3dc),
  );
  static ThemeData darkTheme =
      ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark());
}
