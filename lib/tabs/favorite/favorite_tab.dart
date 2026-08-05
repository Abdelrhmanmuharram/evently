import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/events_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/event_item.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  late EventsProvider eventsProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserProvider userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      eventsProvider.filterFavoriteEvents(
        userProvider.currentUser!.favoriteEventIds,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    eventsProvider = Provider.of<EventsProvider>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DefaultTextFormField(
              hintText: appLocalizations.searchForEvent,
              suffixIconImageName: 'search',
              onChange: (query) {
                eventsProvider.searchFavoriteEvents(query);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) =>
                    EventItem(eventsProvider.displayedFavoriteEvents[index]),
                separatorBuilder: (_, _) => SizedBox(height: 16),
                itemCount: eventsProvider.displayedFavoriteEvents.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
