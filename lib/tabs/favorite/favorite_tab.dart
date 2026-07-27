import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../widgets/event_item.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DefaultTextFormField(
              hintText: 'Search for events',
              suffixIconImageName: 'search',
            ),
            const SizedBox(height: 16),
            // Expanded(
            //   child: ListView.separated(
            //     itemBuilder: (_, index) => EventItem(
            //     ),
            //     separatorBuilder: (_, _) => SizedBox(height: 16),
            //     itemCount: 10,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
