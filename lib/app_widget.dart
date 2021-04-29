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
        accentColor: secondaryDarkColor,
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
          onSurface: Colors.red,
          onBackground: Colors.black,
          onError: Colors.amber,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          color: primaryColor,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: primaryColor,
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      ),
    ).modular();
  }
}
