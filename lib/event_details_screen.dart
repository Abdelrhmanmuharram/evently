import 'package:evently/firebase_service.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/widgets/action_item.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:evently/widgets/info_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'edit_event_screen.dart';
import 'l10n/app_localizations.dart';
import 'models/event_model.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = '/event-details';
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;

    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    EventModel event = ModalRoute.of(context)!.settings.arguments as EventModel;
    TextTheme textTheme = Theme.of(context).textTheme;
    MediaQueryData screenSize = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: ActionItem(
          svgPicture: settingsProvider.isArabic
              ? settingsProvider.isDark
                    ? 'arrow_right'
                    : 'arrow_right_light'
              : settingsProvider.isDark
              ? 'arrow_back_light'
              : 'arrow_back',
        ),
        title: Text(appLocalizations.details),
        actions: [
          if (event.ownerId == currentUid)
            ActionItem(
              svgPicture: 'edit',
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(EditEventScreen.routeName, arguments: event);
              },
            ),
          if (event.ownerId == currentUid)
            ActionItem(
              svgPicture: 'delete',
              onPressed: () async {
                await FirebaseService.deleteEvent(
                  event,
                ).then((_) => Navigator.of(context).pop());
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        'assets/images/${event.category.type}_dark.png',
                        width: .infinity,
                        height: screenSize.size.height * .23,
                        fit: .fill,
                      )
                    : Image.asset(
                        'assets/images/${event.category.type}.png',
                        width: .infinity,
                        height: screenSize.size.height * .23,
                        fit: .fill,
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              event.title,
              style: textTheme.titleMedium!.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 16),
            InfoCard(
              DateFormat('d MMMM').format(event.dateTime),
              DateFormat('h:mm a').format(event.dateTime),
            ),
            const SizedBox(height: 16),
            Text(appLocalizations.description, style: textTheme.titleMedium),
            const SizedBox(height: 16),
            DefaultTextFormField(
              hintText: '',
              maxLine: 5,
              controller: TextEditingController(text: event.description),
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
