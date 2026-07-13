import 'package:flutter/material.dart';

import '../../widgets/event_item.dart';
import 'home_header.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeHeader(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (_, _) => EventItem(),
              separatorBuilder: (_, _) => SizedBox(height: 16),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
