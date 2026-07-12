import 'package:flutter/material.dart';

import 'home_header.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [HomeHeader()]));
  }
}
