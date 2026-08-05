import 'package:evently/models/user_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../models/category_model.dart';
import '../../providers/settings_provider.dart';
import '../../providers/user_provider.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<UserProvider>(context).currentUser!;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: settingsProvider.isArabic
            ? const EdgeInsets.only(right: 16)
            : const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(appLocalizations.welcomeBack, style: textTheme.titleSmall),
            Text(currentUser.name, style: textTheme.titleLarge),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: DefaultTabController(
                length: CategoryModel.categories.length + 1,
                child: TabBar(
                  isScrollable: true,
                  tabAlignment: .start,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  labelPadding: EdgeInsets.only(right: 8),
                  tabs: [
                    TabItem(
                      isSelected: currentIndex == 0,
                      label: appLocalizations.all,
                      iconPath: 'assets/icons/all.svg',
                    ),
                    ...CategoryModel.categories.map(
                      (category) => TabItem(
                        isSelected:
                            currentIndex ==
                            CategoryModel.categories.indexOf(category) + 1,
                        label: category.getName(appLocalizations),
                        iconPath: category.iconPath,
                      ),
                    ),
                  ],
                  onTap: (index) {
                    if (currentIndex == index) return;
                    currentIndex = index;
                    CategoryModel? selectedCategory = index == 0
                        ? null
                        : CategoryModel.categories[index - 1];
                    Provider.of<EventsProvider>(
                      context,
                      listen: false,
                    ).filterEvents(selectedCategory);
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
