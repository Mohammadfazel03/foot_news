import 'package:flutter/material.dart';

class MaterialColors {
  static const MaterialColor greenWin = MaterialColor(_greenWinPrimaryValue, <int, Color>{
    50: Color(0xFFE1F3EB),
    100: Color(0xFFB3E2CC),
    200: Color(0xFF81CEAB),
    300: Color(0xFF4EBA89),
    400: Color(0xFF28AC6F),
    500: Color(_greenWinPrimaryValue),
    600: Color(0xFF02954F),
    700: Color(0xFF018B45),
    800: Color(0xFF01813C),
    900: Color(0xFF016F2B),
  });
  static const int _greenWinPrimaryValue = 0xFF029D56;

  static const MaterialColor greenWinAccent = MaterialColor(_greenWinAccentValue, <int, Color>{
    100: Color(0xFF9EFFBB),
    200: Color(_greenWinAccentValue),
    400: Color(0xFF38FF74),
    700: Color(0xFF1FFF62),
  });
  static const int _greenWinAccentValue = 0xFF6BFF98;

  static const MaterialColor redLose = MaterialColor(_redLosePrimaryValue, <int, Color>{
    50: Color(0xFFFDE2E2),
    100: Color(0xFFFBB7B7),
    200: Color(0xFFF98888),
    300: Color(0xFFF65858),
    400: Color(0xFFF43434),
    500: Color(_redLosePrimaryValue),
    600: Color(0xFFF00E0E),
    700: Color(0xFFEE0C0C),
    800: Color(0xFFEC0909),
    900: Color(0xFFE80505),
  });
  static const int _redLosePrimaryValue = 0xFFF21010;

  static const MaterialColor redLoseAccent = MaterialColor(_redLoseAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_redLoseAccentValue),
    400: Color(0xFFFFAAAA),
    700: Color(0xFFFF9191),
  });
  static const int _redLoseAccentValue = 0xFFFFDDDD;

  static const MaterialColor amberDraw = MaterialColor(_amberDrawPrimaryValue, <int, Color>{
    50: Color(0xFFFFF6E6),
    100: Color(0xFFFFE8C1),
    200: Color(0xFFFFD997),
    300: Color(0xFFFFC96D),
    400: Color(0xFFFFBE4E),
    500: Color(_amberDrawPrimaryValue),
    600: Color(0xFFFFAB2A),
    700: Color(0xFFFFA223),
    800: Color(0xFFFF991D),
    900: Color(0xFFFF8A12),
  });
  static const int _amberDrawPrimaryValue = 0xFFFFB22F;

  static const MaterialColor amberDrawAccent = MaterialColor(_amberDrawAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_amberDrawAccentValue),
    400: Color(0xFFFFE1C6),
    700: Color(0xFFFFD3AD),
  });
  static const int _amberDrawAccentValue = 0xFFFFFCF9;

  static const MaterialColor redTimer = MaterialColor(_redTimerPrimaryValue, <int, Color>{
    50: Color(0xFFFEE9EB),
    100: Color(0xFFFEC8CC),
    200: Color(0xFFFDA3AA),
    300: Color(0xFFFC7E88),
    400: Color(0xFFFB626F),
    500: Color(_redTimerPrimaryValue),
    600: Color(0xFFF93F4E),
    700: Color(0xFFF93744),
    800: Color(0xFFF82F3B),
    900: Color(0xFFF6202A),
  });
  static const int _redTimerPrimaryValue = 0xFFFA4655;

  static const MaterialColor redTimerAccent = MaterialColor(_redTimerAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_redTimerAccentValue),
    400: Color(0xFFFFC7C9),
    700: Color(0xFFFFADB1),
  });
  static const int _redTimerAccentValue = 0xFFFFFAFA;
}
