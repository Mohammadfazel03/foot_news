part of 'theme_cubit.dart';

class ThemeState {

  late final ThemeApp themeApp;

  ThemeState({required this.themeApp});

  ThemeState.init() {
    themeApp = ThemeApp.lightTheme;
  }
}

