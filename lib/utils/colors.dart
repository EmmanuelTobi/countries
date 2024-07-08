import 'package:countries/utils/themes.dart';
import 'package:flutter/material.dart';

class XColors {

  static bool getDarkMode = false;

  static Color background() => getDarkMode != true ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
  static Color white() => ThemesSetup().isDark != true ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
  static Color black() => const Color(0xFF000000);
  static Color primaryColor() => Colors.purpleAccent;
  static Color primaryColor2() => const Color(0xFF6E118D);
  //static Color primaryColor() => const Color(0xFF6D118D);
  static Color surfaceColor() => getDarkMode != true ? const Color(0xFFC42D32) : const Color(0xFFFFFFFF);
  static Color decoratorContainerColor() => getDarkMode != true ? const Color(0xFFFFFFFF) : const Color(0xFF2D0203) ;
  static Color textColor() => ThemesSetup().isDark != true ? Colors.black87 : const Color(0xFFFFFFFF).withOpacity(0.9);

}
