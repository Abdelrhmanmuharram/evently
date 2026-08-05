import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = .system;
  String languageCode = 'ar';

  bool get isDark => themeMode == .dark;
  bool get isArabic => languageCode == 'ar';

  void changeTheme(ThemeMode theme) {
    themeMode = theme;
    notifyListeners();
  }
  void changeLanguage(String language) {
    if(languageCode == language) return;
    languageCode = language;
    notifyListeners();
  }
}
