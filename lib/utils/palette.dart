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

const Color secondary = MermaidLagoon.darkBlue;
const Color primary = MermaidLagoon.midnightBlue;
// static TextTheme secondaryFont = GoogleFonts.poppinsTextTheme();
ThemeData lightTheme = ThemeData(
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: primary),
  colorScheme: const ColorScheme.light()
      .copyWith(primary: primary, secondary: secondary),
  appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black)),
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    elevation: 0,
    color: Colors.transparent,
  ),
  textTheme: GoogleFonts.workSansTextTheme(),
  scaffoldBackgroundColor: const Color(0xfff0f1f5),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    materialTapTargetSize: MaterialTapTargetSize.padded,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  chipTheme: ChipThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: const BorderSide(width: 1, color: primary),
      borderRadius: BorderRadius.circular(10),
    ),
  )),
  buttonTheme: const ButtonThemeData(buttonColor: secondary),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    suffixIconColor: Colors.black87,
    prefixIconColor: secondary,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: secondary),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
  ),
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    elevation: 0,
    color: Colors.transparent,
  ),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: primary,
    secondary: secondary,
  ),
  fontFamily: GoogleFonts.workSans().fontFamily,
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
  )),
  checkboxTheme: CheckboxThemeData(
    materialTapTargetSize: MaterialTapTargetSize.padded,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  chipTheme: ChipThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: const BorderSide(width: 1, color: primary),
      borderRadius: BorderRadius.circular(10),
    ),
  )),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    suffixIconColor: Colors.white60,
    prefixIconColor: secondary,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);
