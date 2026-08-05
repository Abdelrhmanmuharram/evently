import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'models/user_model.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventCollection() =>
      FirebaseFirestore.instance
          .collection('event')
          .withConverter<EventModel>(
            fromFirestore: (snapshot, _) =>
                EventModel.fromJson(snapshot.data()!),
            toFirestore: (event, _) => event.toJson(),
          );

  static CollectionReference<UserModel> getUserCollection() => FirebaseFirestore
      .instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  static Future<void> createEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    DocumentReference eventDoc = eventCollection.doc();
    event.id = eventDoc.id;
    return eventDoc.set(event);
  }

  static Future<List<EventModel>> getEvents() async {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    QuerySnapshot<EventModel> querySnapshot = await eventCollection
        .orderBy('timeStamp')
        .get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> editEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    DocumentReference eventDoc = eventCollection.doc(event.id);
    return eventDoc.update(event.toJson());
  }

  static Future<void> deleteEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    DocumentReference eventDoc = eventCollection.doc(event.id);
    return eventDoc.delete();
  }

  static Future<UserModel> register(
    String name,
    String email,
    String password,
  ) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
      favoriteEventIds: [],
    );
    CollectionReference<UserModel> userCollection = getUserCollection();
    await userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login(String email, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentSnapshot<UserModel> docSnapshot = await userCollection
        .doc(credential.user!.uid)
        .get();
    return docSnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();

  static Future<void> addFavoriteEvent(String eventId) async {
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentReference<UserModel> userDoc = userCollection.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return userDoc.update({
      'favoriteEventIds': FieldValue.arrayUnion([eventId]),
    });
  }

  static Future<void> removeFavoriteEvent(String eventId) async {
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentReference<UserModel> userDoc = userCollection.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return userDoc.update({
      'favoriteEventIds': FieldValue.arrayRemove([eventId]),
    });
  }

  static Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      CollectionReference<UserModel> userCollection = getUserCollection();
      DocumentSnapshot<UserModel> docSnapshot =
      await userCollection.doc(userCredential.user!.uid).get();
      UserModel user;
      if (!docSnapshot.exists) {
        user = UserModel(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? '',
          email: userCredential.user!.email ?? '',
          favoriteEventIds: [],
        );
        await userCollection.doc(user.id).set(user);
      } else {
        user = docSnapshot.data()!;
      }
      return user;
    } catch (e) {
      print('خطأ: $e');
      return null;
    }
  }
}
