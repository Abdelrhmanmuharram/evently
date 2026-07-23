import 'package:evently/auth/login_screen.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'create_event_screen.dart';
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
        RegisterScreen.routeName : (_) => const RegisterScreen(),
        LoginScreen.routeName : (_) => const LoginScreen(),
        CreateEventScreen.routeName : (_) => const CreateEventScreen(),
      },
      initialRoute: HomeScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
