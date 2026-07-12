import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  IconData icon;
  String imageName;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageName,
    required this.icon,
  });

  static List<CategoryModel> categories = [
    CategoryModel(
      id: '1',
      name: 'Sport',
      imageName: 'sport',
      icon: Icons.sports_baseball,
    ),
    CategoryModel(
      id: '2',
      name: 'Birthday',
      imageName: 'birthday',
      icon: Icons.cake_outlined,
    ),
  ];
}
