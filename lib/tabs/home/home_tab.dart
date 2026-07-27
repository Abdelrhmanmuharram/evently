import 'package:evently/firebase_service.dart';
import 'package:evently/models/event_model.dart';
import 'package:flutter/material.dart';

import '../../widgets/event_item.dart';
import 'home_header.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<EventModel> events = [];
  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      getEvents();
    }
    return Scaffold(
      body: Column(
        children: [
          HomeHeader(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (_, index) => EventItem(events[index]),
              separatorBuilder: (_, _) => SizedBox(height: 16),
              itemCount: events.length,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getEvents() async {
    events = await FirebaseService.getEvents();
    setState(() {});
  }
}
