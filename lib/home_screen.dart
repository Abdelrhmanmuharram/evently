import 'package:evently/nav_bar_icon.dart';
import 'package:evently/tabs/favorite/favorite_tab.dart';
import 'package:evently/tabs/home/home_tab.dart';
import 'package:evently/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';

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
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: NavBarIcon(iconName: 'home'),
            activeIcon: NavBarIcon(iconName: 'home_active'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: NavBarIcon(iconName: 'favorite'),
            activeIcon: NavBarIcon(iconName: 'favorite_active'),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: NavBarIcon(iconName: 'profile'),
            activeIcon: NavBarIcon(iconName: 'profile_active'),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: NavBarIcon(iconName: 'profile'),
            activeIcon: NavBarIcon(iconName: 'profile_active'),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: .endFloat,
    );
  }
}
