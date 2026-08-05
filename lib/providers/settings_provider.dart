import 'package:flutter/material.dart';

import '../shared_preferences_service.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = .system;
  String languageCode = 'en';

  SettingsProvider() {
    loadSettings();
  }

  bool get isDark => themeMode == .dark;
  bool get isArabic => languageCode == 'ar';

  void changeTheme(ThemeMode theme) {
    if (themeMode == theme) return;
    themeMode = theme;
    SharedPreferencesService.saveTheme(
      theme == ThemeMode.dark,
    );
    print("Saved Theme: ${theme == ThemeMode.dark}");
    notifyListeners();
  }

  void changeLanguage(String language) {
    if (languageCode == language) return;
    languageCode = language;
    SharedPreferencesService.saveLanguage(language);
    print("Saved Language: $language");
    notifyListeners();
  }

  void loadSettings() {
    languageCode = SharedPreferencesService.getLanguage();
    bool isDark = SharedPreferencesService.getTheme();
    print("Language: $languageCode");
    print("IsDark: $isDark");
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
