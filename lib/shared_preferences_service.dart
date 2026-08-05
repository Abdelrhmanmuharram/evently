import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences prefs;
  static const String themeKey = 'theme';
  static const String languageKey = 'language';

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveLanguage(String languageCode) async {
    await prefs.setString(languageKey, languageCode);
  }

  static Future<void> saveTheme(bool isDark) async {
    await prefs.setBool(themeKey, isDark);
  }

  static bool getTheme() {
    return prefs.getBool(themeKey) ?? false;
  }

  static String getLanguage() {
    return prefs.getString(languageKey) ?? 'en';
  }
}
