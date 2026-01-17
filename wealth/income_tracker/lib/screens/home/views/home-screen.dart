import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:income_tracker/screens/add_assert/views/blocks/add_assert.dart';
import 'package:income_tracker/screens/home/views/main_screen.dart';
import 'package:income_tracker/screens/stats/stats.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final Color selectedItem = const Color(0xFF00B2E7);
  final Color unselectedItem = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                color: index == 0 ? selectedItem : unselectedItem,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.graph_square_fill,
                color: index == 1 ? selectedItem : unselectedItem,
              ),
              label: "Graphs",
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder:(BuildContext context) =>const AddAssert(),
            )
          );
        },
        shape: const CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xFF00B2E7),
                Color.fromARGB(255, 101, 10, 117),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      body: index == 0 ? const MainScreen() : const StatScreen(),
    );
  }
}
