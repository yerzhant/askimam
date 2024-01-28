import 'package:askimam/common/ui/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color.fromARGB(255, 61, 111, 229);
const primaryLightColor = Color.fromARGB(255, 211, 224, 255);
const primaryDarkColor = Color.fromARGB(255, 41, 84, 183);
const warningColor = Color.fromARGB(255, 215, 23, 167);
const grayColor = Color(0xffa0a0a0);

ThemeData theme(BuildContext context) {
  final elMessiri = GoogleFonts.elMessiriTextTheme();
  final poireOne = GoogleFonts.poiretOne(fontSize: 15);

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    textTheme: elMessiri.copyWith(
      bodySmall: elMessiri.bodySmall!.copyWith(color: grayColor),
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
    ),
    filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(textStyle: MaterialStatePropertyAll(poireOne))),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
    dividerTheme: const DividerThemeData(
      space: 0,
      thickness: .3,
      indent: basePadding,
      endIndent: basePadding,
      color: grayColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryDarkColor,
      unselectedItemColor: primaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: primaryDarkColor,
    ),
  );
}
