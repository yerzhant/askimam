import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color.fromARGB(255, 61, 111, 229);
const primaryLightColor = Color.fromARGB(255, 61, 111, 229);
const primaryDarkColor = Color.fromARGB(255, 41, 84, 183);
const secondaryColor = Color(0xffccff56);
const secondaryDarkColor = Color(0xff98cc19);
const secondaryTextColor = Color(0xff000000);
const grayColor = Color(0xffa0a0a0);

ThemeData theme(BuildContext context) {
  final text = GoogleFonts.elMessiriTextTheme();
  final buttonText = GoogleFonts.poiretOne(fontSize: 15);

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    textTheme: text.copyWith(
      bodySmall: text.bodySmall!.copyWith(color: grayColor),
    ),
    filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(textStyle: MaterialStatePropertyAll(buttonText))),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    dividerTheme: const DividerThemeData(
      space: 0,
      thickness: .3,
      indent: 16,
      endIndent: 16,
      color: grayColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryDarkColor,
      unselectedItemColor: primaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: secondaryColor,
      contentTextStyle: TextStyle(color: secondaryTextColor),
    ),
  );
}
