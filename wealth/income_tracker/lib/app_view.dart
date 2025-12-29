import 'package:flutter/material.dart';
import 'package:income_tracker/screens/home/views/home-screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Income Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: const Color.fromARGB(255, 216, 215, 215), 
          onSurface: Colors.black,
          primary: const Color(0xFF00B2E7), 
          secondary: const Color(0xFFE064F7), 
          tertiary: const Color(0xFFFF8D6C), 
          outline: Colors.grey)),
    home: HomeScreen(),
    );
  }
}