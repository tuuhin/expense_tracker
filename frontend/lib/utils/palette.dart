import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Palette {
  static ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.workSans().fontFamily,
    scaffoldBackgroundColor: const Color(0xfff0f1f5),
    primarySwatch: Colors.green,
  );
  static ThemeData darkTheme = ThemeData(
      colorScheme: const ColorScheme.dark(),
      fontFamily: GoogleFonts.workSans().fontFamily);
}
