import 'package:evently/app_theme.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabItem extends StatelessWidget {
  String label;
  IconData icon;
  bool isSelected;
  TabItem({
    super.key,
    required this.isSelected,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected
            ? primaryColor
            : settingsProvider.isDark
            ? AppTheme.navy
            : AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : settingsProvider.isDark
              ? AppTheme.borderDark
              : AppTheme.secondText.withAlpha(50),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: isSelected ? AppTheme.white : primaryColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextTheme.of(context).titleMedium!.copyWith(
              color: isSelected
                  ? AppTheme.white
                  : settingsProvider.isDark
                  ? AppTheme.white
                  : AppTheme.mainText,
            ),
          ),
        ],
      ),
    );
  }
}
