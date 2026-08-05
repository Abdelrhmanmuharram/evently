import 'package:evently/app_theme.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../event_details_screen.dart';
import '../providers/settings_provider.dart';
import '../providers/user_provider.dart';

class EventItem extends StatelessWidget {
  EventModel event;
  EventItem(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    bool isFavorite = userProvider.checkFavoriteEvent(event.id);
    TextTheme textTheme = Theme.of(context).textTheme;
    Color primaryColor = Theme.of(context).primaryColor;
    MediaQueryData screenSize = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(EventDetailsScreen.routeName, arguments: event);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: settingsProvider.isDark
                    ? AppTheme.borderDark
                    : AppTheme.secondText.withAlpha(50),
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: settingsProvider.isDark
                  ? Image.asset(
                      'assets/images/${event.category.imageName}_dark.png',
                      width: .infinity,
                      height: screenSize.size.height * .23,
                      fit: .fill,
                    )
                  : Image.asset(
                      'assets/images/${event.category.imageName}.png',
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
              color: settingsProvider.isDark
                  ? AppTheme.backgroundDark
                  : AppTheme.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: settingsProvider.isDark
                    ? AppTheme.borderDark
                    : AppTheme.secondText.withAlpha(50),
              ),
            ),
            child: Text(
              DateFormat('d MMM').format(event.dateTime),
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
                color: settingsProvider.isDark
                    ? AppTheme.backgroundDark
                    : AppTheme.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: settingsProvider.isDark
                      ? AppTheme.borderDark
                      : AppTheme.secondText.withAlpha(50),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      style: textTheme.titleSmall!.copyWith(
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.mainText,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      if (isFavorite) {
                        userProvider.removeFavoriteEvent(event.id);
                        Provider.of<EventsProvider>(
                          context,
                          listen: false,
                        ).filterFavoriteEvents(
                          userProvider.currentUser!.favoriteEventIds,
                        );
                      } else {
                        userProvider.addFavoriteEvent(event.id);
                      }
                    },
                    child: isFavorite
                        ? SvgPicture.asset(
                            'assets/icons/favorite_active.svg',
                            width: 24,
                            height: 24,
                            fit: .scaleDown,
                            colorFilter: ColorFilter.mode(
                              primaryColor,
                              BlendMode.srcIn,
                            ),
                          )
                        : SvgPicture.asset(
                            'assets/icons/favorite.svg',
                            width: 24,
                            height: 24,
                            fit: .scaleDown,
                            colorFilter: ColorFilter.mode(
                              primaryColor,
                              BlendMode.srcIn,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
