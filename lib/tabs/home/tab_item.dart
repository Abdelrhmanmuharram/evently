import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.transparent : AppTheme.secondText.withAlpha(50),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? AppTheme.white : primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextTheme.of(context).titleMedium!.copyWith(
              color: isSelected ? AppTheme.white : AppTheme.mainText,
            ),
          ),
        ],
      ),
    );
  }
}
