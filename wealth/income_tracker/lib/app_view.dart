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
          surface: const Color.fromARGB(255, 242, 242, 242), 
          onSurface: Colors.black,
          primary: const Color(0xFF493A96), 
          secondary: const Color(0xFFE064F7), 
          tertiary: const Color.fromARGB(255, 207, 197, 195), 
          outline: Colors.grey)),
    home: HomeScreen(),
    );
  }
}