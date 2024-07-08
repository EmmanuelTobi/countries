import 'package:flutter/material.dart';

final setLightTheme = _buildLightTheme();
final setDarkTheme = _buildDarkTheme();

ThemeData _buildLightTheme() {
  return ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black54,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFFFFFFF),
    dividerColor: Colors.white54,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    bottomSheetTheme: const BottomSheetThemeData(surfaceTintColor: Colors.white),
    useMaterial3: true,
    fontFamily: "Axiforma",
  );
}

ThemeData _buildDarkTheme() {
  return ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF000000),
    dividerColor: Colors.black12,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(),
    bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Colors.black,
      backgroundColor: Colors.black
    ),
    useMaterial3: true,
    fontFamily: "Axiforma",
  );
}

class ThemesSetup {
  factory ThemesSetup() {
    return _instance!;
  }

  ThemesSetup._();
  static ThemesSetup? _instance;

  bool? isDark;

  static ThemeData getThemeDataFromThemeMode(BuildContext context, AppThemeMode currentThemeMode) {

    _instance ??= ThemesSetup._();
    ThemeData resultantTheme = _buildLightTheme();

    switch(currentThemeMode) {
      case AppThemeMode.SYSTEM: {
        final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
        _instance!.isDark = brightnessValue == Brightness.dark;

        if(_instance!.isDark!) {
          resultantTheme = _buildDarkTheme();
        } else {
          resultantTheme = _buildLightTheme();
        }
      }
      break;

      case AppThemeMode.DARK: {
        _instance!.isDark = true;
        resultantTheme = _buildDarkTheme();
      }
      break;

      case AppThemeMode.LIGHT: {
        _instance!.isDark = false;
        resultantTheme = _buildLightTheme();
      }

      break;

      default: {
        _instance!.isDark = true;
        resultantTheme = _buildLightTheme();
      }

    }

    return resultantTheme;

  }

}

enum AppThemeMode {
  SYSTEM,
  LIGHT,
  DARK
}