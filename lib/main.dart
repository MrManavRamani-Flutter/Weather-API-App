import 'package:flutter/material.dart';
import 'package:sky_scrapper_api/views/intro/welcome_screen.dart';
import 'package:sky_scrapper_api/views/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Application',
      initialRoute: 'welcome',
      routes: {
        '/': (context) => const HomeScreen(),
        'welcome': (context) => const WelcomeScreen(),
      },
    );
  }
}
