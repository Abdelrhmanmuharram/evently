import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventCollection() =>
      FirebaseFirestore.instance
          .collection('event')
          .withConverter<EventModel>(
            fromFirestore: (snapshot, _) =>
                EventModel.fromJson(snapshot.data()!),
            toFirestore: (event, _) => event.toJson(),
          );
  static Future<void> createEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    DocumentReference eventDoc = eventCollection.doc();
    event.id = eventDoc.id;
    return eventDoc.set(event);
  }
}
