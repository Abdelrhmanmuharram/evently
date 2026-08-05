import '../l10n/app_localizations.dart';

class LanguageModel {
  final String code;
  LanguageModel({required this.code});

  String getLanguageName(AppLocalizations appLocalizations) {
    switch (code) {
      case 'en':
        return appLocalizations.english;
      case 'ar':
        return appLocalizations.arabic;
      default:
        return code;
    }
  }

  static List<LanguageModel> languages = [
    LanguageModel(code: 'en'),
    LanguageModel(code: 'ar'),
  ];
}
