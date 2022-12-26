import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_palettes.dart';

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
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
    ),
  ),
  buttonTheme: const ButtonThemeData(buttonColor: secondary),
  inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      suffixIconColor: Colors.black87,
      prefixIconColor: secondary,
      floatingLabelStyle:
          const TextStyle(fontWeight: FontWeight.w600, color: secondary),
      labelStyle: const TextStyle(fontWeight: FontWeight.w400),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.black45),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.black45),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: secondary),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1.25, color: secondary),
        borderRadius: BorderRadius.circular(10),
      ),
      errorStyle: const TextStyle(color: secondary)),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
      borderRadius: BorderRadius.circular(5),
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
