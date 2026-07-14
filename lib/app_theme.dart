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
  static const Color switchBackground = Color(0xFFE9EAEB);
  static const Color grey = Color(0xFFB9B9B9);
  static const Color line = Color(0xFFF0F0F0);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: white,
      selectedItemColor: primary,
      unselectedItemColor: secondText,
      type: BottomNavigationBarType.fixed,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(),
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: TextStyle(
        color: secondText,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: secondText.withAlpha(50)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primary),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: .w600,

          decoration: .underline,
        ),
      ),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: white,
      minTileHeight: 0,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppTheme.secondText.withAlpha(50)),
      ),
      titleTextStyle: TextStyle(
        color: mainText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: secondText,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        color: mainText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        color: mainText,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        color: primary,
        fontSize: 24,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData();
}
