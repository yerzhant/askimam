import 'package:askimam/common/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Вопрос имаму',
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: primaryDarkColor,
        colorScheme: const ColorScheme(
          primary: primaryColor,
          primaryVariant: primaryDarkColor,
          secondary: secondaryColor,
          secondaryVariant: secondaryDarkColor,
          surface: Colors.green,
          background: Colors.yellow,
          error: Colors.green,
          onPrimary: primaryTextColor,
          onSecondary: secondaryTextColor,
          onSurface: primaryColor,
          onBackground: Colors.black,
          onError: Colors.amber,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
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
      ),
    ).modular();
  }
}
