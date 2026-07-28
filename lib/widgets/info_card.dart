import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoCard extends StatelessWidget {
  String data;
  String time;
  InfoCard(this.data, this.time, {super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.secondText.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.secondText.withAlpha(50)),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/calendar.svg',
                  width: 24,
                  height: 24,
                  fit: .scaleDown,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data, style: textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(
                time,
                style: textTheme.titleMedium!.copyWith(
                  color: AppTheme.disable,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
