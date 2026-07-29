import 'package:evently/tabs/home/tab_item.dart';
import 'package:flutter/material.dart';

import '../../models/category_model.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back ✨', style: textTheme.titleSmall),
            Text('User Name', style: textTheme.titleLarge),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
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
                      label: 'All',
                      icon: Icons.category_outlined,
                    ),
                    ...CategoryModel.categories.map(
                      (category) => TabItem(
                        isSelected:
                            currentIndex ==
                            CategoryModel.categories.indexOf(category) + 1,
                        label: category.name,
                        icon: category.icon,
                      ),
                    ),
                  ],
                  onTap: (index) {
                    if (currentIndex == index) return;
                    currentIndex = index;
                    setState(() {});
                    if (index == 0) {
                    } else {
                      CategoryModel selectedCategory =
                          CategoryModel.categories[index - 1];
                    }
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
