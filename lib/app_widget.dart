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
        colorScheme: const ColorScheme(
          primary: primaryColor,
          primaryVariant: primaryDarkColor,
          secondary: secondaryColor,
          secondaryVariant: secondaryDarkColor,
          surface: Colors.red,
          background: Colors.red,
          error: Colors.red,
          onPrimary: primaryTextColor,
          onSecondary: secondaryTextColor,
          onSurface: Colors.red,
          onBackground: Colors.red,
          onError: Colors.red,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          color: primaryColor,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: primaryColor,
        ),
      ),
    ).modular();
  }
}
