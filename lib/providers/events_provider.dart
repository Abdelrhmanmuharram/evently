import 'package:evently/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:flutter/material.dart';

import '../models/event_model.dart';

class EventsProvider with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> displayedEvents = [];
  List<EventModel> favoriteEvents = [];
  List<EventModel> displayedFavoriteEvents = [];

  Future<void> getEvents() async {
    allEvents = await FirebaseService.getEvents();
    displayedEvents = allEvents;
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
    displayedFavoriteEvents = favoriteEvents;
    notifyListeners();
  }

  void searchFavoriteEvents(String query) {
    if (query.isEmpty) {
      displayedFavoriteEvents = favoriteEvents;
    } else {
      displayedFavoriteEvents = favoriteEvents.where((event) {
        return event.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
