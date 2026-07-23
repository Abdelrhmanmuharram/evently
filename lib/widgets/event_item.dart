import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Color primaryColor = Theme.of(context).primaryColor;
    MediaQueryData screenSize = MediaQuery.of(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.secondText.withAlpha(50)),
            borderRadius: BorderRadius.circular(18),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/images/sport.png',
              width: .infinity,
              height: screenSize.size.height * .23,
              fit: .fill,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.secondText.withAlpha(50)),
          ),
          child: Text(
            '21 Jan',
            style: textTheme.titleMedium!.copyWith(
              color: primaryColor,
              fontWeight: .bold,
            ),
          ),
        ),
        Positioned(
          width: screenSize.size.width - 32,
          bottom: 0,
          child: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.secondText.withAlpha(50)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'This is a Birthday Party',
                    style: textTheme.titleSmall!.copyWith(
                      color: AppTheme.mainText,
                      fontWeight: .bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/favorite.svg',
                  width: 24,
                  height: 24,
                  fit: .scaleDown,
                  colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
