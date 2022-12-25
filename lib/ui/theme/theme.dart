import 'package:flutter/material.dart';

final ThemeData _darkTheme = ThemeData(
  primaryColorDark: const Color.fromRGBO(33, 37, 41, 1),
  primaryColor: const Color.fromRGBO(18, 25, 45, 1.0),
  primaryColorLight: const Color.fromRGBO(33, 39, 60, 1.0),
  colorScheme: _darkTheme.colorScheme.copyWith(
    secondary: const Color.fromRGBO(255, 107, 22, 1.0),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  unselectedWidgetColor: const Color.fromRGBO(145, 145, 145, 1),
  canvasColor: const Color.fromRGBO(76, 85, 123, 1.0)
);

final themeApp = {
  ThemeApp.DarkTheme: _darkTheme,
  ThemeApp.LightTheme: ThemeData(cardColor: Colors.redAccent),
};

enum ThemeApp { DarkTheme, LightTheme }
