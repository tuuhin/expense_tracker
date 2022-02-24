import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Palette {
  static const Color secondary = Color(0xff3b3dbf);
  static const Color primary = Color(0xff7fc3dc);

  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
        primary: primary, secondary: secondary, error: Colors.redAccent),
    fontFamily: GoogleFonts.workSans().fontFamily,
    scaffoldBackgroundColor: const Color(0xfff0f1f5),
    buttonTheme: const ButtonThemeData(buttonColor: secondary),
    inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Colors.black87,
      prefixIconColor: secondary,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondary, width: 1.75),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    primaryColor: const Color(0xff7fc3dc),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark().copyWith(
        primary: primary, secondary: secondary, error: Colors.redAccent),
    fontFamily: GoogleFonts.workSans().fontFamily,
    inputDecorationTheme: const InputDecorationTheme(
      prefixIconColor: secondary,
      suffixIconColor: Colors.white70,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondary, width: 1.75),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
}
