import 'package:flutter/material.dart';
import 'package:solar_system/screens/home_screen.dart';
import 'package:solar_system/screens/setting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Solar System',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/Setting': (context) => SettingScreen(),
      },
    );
  }
}