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
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondary, width: 1.75),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
    ),
    primaryColor: const Color(0xff7fc3dc),
  );
  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark()
        .copyWith(primary: primary, secondary: secondary),
    fontFamily: GoogleFonts.workSans().fontFamily,
    inputDecorationTheme: const InputDecorationTheme(
      prefixIconColor: primary,
      suffixIconColor: Colors.white70,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondary, width: 1.75),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
    ),
  );
}
