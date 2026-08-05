import 'package:evently/create_event_screen.dart';
import 'package:evently/nav_bar_icon.dart';
import 'package:evently/tabs/favorite/favorite_tab.dart';
import 'package:evently/tabs/home/home_tab.dart';
import 'package:evently/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [HomeTab(), FavoriteTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (index) {
          if (currentIndex == index) return;
          currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: NavBarIcon(iconName: 'home'),
            activeIcon: NavBarIcon(iconName: 'home_active'),
            label: appLocalizations.home,
          ),
          BottomNavigationBarItem(
            icon: NavBarIcon(iconName: 'favorite'),
            activeIcon: NavBarIcon(iconName: 'favorite_active'),
            label: appLocalizations.favorite,
          ),
          BottomNavigationBarItem(
            icon: NavBarIcon(iconName: 'profile'),
            activeIcon: NavBarIcon(iconName: 'profile_active'),
            label: appLocalizations.profile,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(CreateEventScreen.routeName),
        child: Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: .endFloat,
    );
  }
}
