import 'package:evently/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:flutter/material.dart';

import '../models/event_model.dart';

class EventsProvider with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> displayedEvents = [];
  List<EventModel> favoriteEvents = [];

  Future<void> getEvents() async {
    allEvents = await FirebaseService.getEvents();
    notifyListeners();
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      displayedEvents = allEvents;
    } else {
      displayedEvents = allEvents
          .where((event) => event.category == category)
          .toList();
    }
    notifyListeners();
  }

  void filterFavoriteEvents(List<String> favoriteEventIds) {
    favoriteEvents = allEvents
        .where((event) => favoriteEventIds.contains(event.id))
        .toList();
    notifyListeners();
  }
}
