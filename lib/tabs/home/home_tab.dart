import 'package:evently/firebase_service.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/event_item.dart';
import 'home_header.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          HomeHeader(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (_, index) =>
                  EventItem(eventsProvider.displayedEvents[index]),
              separatorBuilder: (_, _) => SizedBox(height: 16),
              itemCount: eventsProvider.displayedEvents.length,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
