import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:income_tracker/screens/home/views/main_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 248, 253, 255),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.graph_square_fill), label: "graphs")
        ]
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: Container(
          width: 60,
          height: 60 ,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF00B2E7), Color.fromARGB(255, 101, 10, 117)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      body:const MainScreen()
    );
  }
}