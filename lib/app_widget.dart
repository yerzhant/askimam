import 'package:askimam/common/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Вопрос имаму',
      theme: ThemeData(
        // TODO
        // accentColor: primaryColor,
        colorScheme: const ColorScheme(
          primary: primaryColor,
          // TODO
          // primaryVariant: primaryDarkColor,
          secondary: secondaryColor,
          // TODO
          // secondaryVariant: secondaryDarkColor,
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
          color: primaryColor,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        dividerTheme: const DividerThemeData(
          space: 0,
          indent: 16,
          endIndent: 16,
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
      routerConfig: Modular.routerConfig,
    );
  }
}
