import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// [https://www.canva.com/colors/color-palettes/summer-splash/]
class SummerSplash {
  static const Color navyBlue = Color(0xff05445e);
  static const Color blueGrotto = Color(0xff189ab4);
  static const Color blueGreen = Color(0xff75e6da);
  static const Color babyBlue = Color(0xffd4f1f4);
}

/// [https://www.canva.com/colors/color-palettes/mermaid-lagoon/]
class MermaidLagoon {
  static const Color midnightBlue = Color(0xff145da0);
  static const Color darkBlue = Color(0xff0c2d48);
  static const Color blue = Color(0xff2e8bc0);
  static const Color babyBlue = Color(0xffb1d4e0);
}

/// [https://www.canva.com/colors/color-palettes/everything-nice/]
class EverythingNice {
  static const Color purple = Color(0xff603f8b);
  static const Color aqua = Color(0xffb4fee7);
  static const Color violet = Color(0xffa16ae8);
  static const Color fuchsia = Color(0xfffd49a0);
}

class Palette {
  static const Color secondary = MermaidLagoon.darkBlue;
  static const Color primary = MermaidLagoon.midnightBlue;
  static TextTheme secondaryFont = GoogleFonts.poppinsTextTheme();

  static ThemeData lightTheme = ThemeData(
    snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    bottomAppBarTheme:
        const BottomAppBarTheme(elevation: 0, color: Colors.transparent),
    colorScheme: const ColorScheme.light().copyWith(
        primary: primary, secondary: secondary, error: Colors.redAccent),
    fontFamily: GoogleFonts.workSans().fontFamily,
    scaffoldBackgroundColor: const Color(0xfff0f1f5),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
    buttonTheme: const ButtonThemeData(buttonColor: secondary),
    inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Colors.black87,
      prefixIconColor: secondary,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondary, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ),
    primaryColor: const Color(0xff7fc3dc),
  );

  static ThemeData darkTheme = ThemeData(
    bottomAppBarTheme:
        const BottomAppBarTheme(elevation: 0, color: Colors.transparent),
    colorScheme: const ColorScheme.dark().copyWith(
        primary: primary, secondary: secondary, error: Colors.redAccent),
    fontFamily: GoogleFonts.workSans().fontFamily,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
    inputDecorationTheme: const InputDecorationTheme(
      prefixIconColor: secondary,
      suffixIconColor: Colors.white70,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondary, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ),
  );
}
