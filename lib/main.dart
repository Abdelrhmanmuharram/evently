import 'package:evently/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'home_screen.dart';

void main() {
  runApp(const EventlyApp());
}

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName : (_) => const HomeScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen()
      },
      initialRoute: RegisterScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
