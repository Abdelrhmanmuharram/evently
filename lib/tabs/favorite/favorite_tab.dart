import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
      eventsProvider.filterFavoriteEvents(
        userProvider.currentUser!.favoriteEventIds,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    eventsProvider = Provider.of<EventsProvider>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DefaultTextFormField(
              hintText: 'Search for events',
              suffixIconImageName: 'search',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) =>
                    EventItem(eventsProvider.favoriteEvents[index]),
                separatorBuilder: (_, _) => SizedBox(height: 16),
                itemCount: eventsProvider.favoriteEvents.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
