import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF0E3A99);
  static const Color background = Color(0xFFF4F7FF);
  static const Color primaryDark = Color(0xFF457AED);
  static const Color backgroundDark = Color(0xFF000F30);
  static const Color mainText = Color(0xFF1C1C1C);
  static const Color secondText = Color(0xFF686868);
  static const Color red = Color(0xFFFF3232);
  static const Color white = Color(0xFFFFFFFF);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: background,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: white,
      selectedItemColor: primary,
      unselectedItemColor: secondText,
      type: BottomNavigationBarType.fixed
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder()
    )
  );
  static ThemeData darkTheme = ThemeData();
}
