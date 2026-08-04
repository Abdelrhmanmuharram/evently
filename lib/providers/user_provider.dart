import 'package:evently/firebase_service.dart';
import 'package:evently/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;

  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }

  bool checkFavoriteEvent(String eventId) {
    return currentUser!.favoriteEventIds.contains(eventId);
  }

  void addFavoriteEvent(String eventId) {
    FirebaseService.addFavoriteEvent(eventId);
    currentUser!.favoriteEventIds.add(eventId);
    notifyListeners();
  }

  void removeFavoriteEvent(String eventId) {
    FirebaseService.removeFavoriteEvent(eventId);
    currentUser!.favoriteEventIds.remove(eventId);
    notifyListeners();
  }
}
