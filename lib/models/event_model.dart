import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/category_model.dart';

class EventModel {
  String id;
  String ownerId;
  String title;
  String description;
  CategoryModel category;
  DateTime dateTime;


  EventModel({
    this.id = '',
    required this.category,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.ownerId,
  });

  EventModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        category: CategoryModel.categories.firstWhere(
          (category) => category.id == json['categoryId'],
        ),
        title: json['title'],
        description: json['description'],
        dateTime: json['timeStamp'].toDate(),
        ownerId: json['ownerId'],
      );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': category.id,
      'title': title,
      'description': description,
      'timeStamp': Timestamp.fromDate(dateTime),
      'ownerId': ownerId,
    };
  }
}
