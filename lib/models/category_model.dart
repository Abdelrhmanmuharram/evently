import '../l10n/app_localizations.dart';

class CategoryModel {
  final String id;
  final String iconPath;
  final String type;

  CategoryModel({required this.id, required this.type, required this.iconPath});

  String getName(AppLocalizations appLocalizations) {
    switch (type) {
      case 'sport':
        return appLocalizations.sports;
      case 'birthday':
        return appLocalizations.birthday;
      default:
        return '';
    }
  }

  static List<CategoryModel> categories = [
    CategoryModel(id: '1', type: 'sport', iconPath: 'assets/icons/sport.svg'),
    CategoryModel(
      id: '2',
      type: 'birthday',
      iconPath: 'assets/icons/birthday.svg',
    ),
  ];
}
