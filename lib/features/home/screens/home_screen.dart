import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

import '../../../theme/pallete.dart';
import '../drawers/navigation_drawer.dart';
import 'courses_screen.dart';
import 'instructors_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _child = const CoursesScreen();

  final List<Widget> _children = [
    const CoursesScreen(),
    const InstructorsScreen(),
  ];

  void _handleNavigationChange(int index) {
    setState(() {
      _child = _children[index];
    });
  }

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taqyeemi'),
        centerTitle: false,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => displayDrawer(context),
          );
        }),
      ),
      body: _child,
      bottomNavigationBar: FluidNavBar(
        style: const FluidNavBarStyle(
          barBackgroundColor: Pallete.grayColor,
          iconSelectedForegroundColor: Pallete.purpleColor,
        ),
        onChange: _handleNavigationChange,
        icons: [
          FluidNavBarIcon(
            icon: Icons.menu_book_rounded,
          ),
          FluidNavBarIcon(
            icon: Icons.people_outline_rounded,
          ),
        ],
      ),
      drawer: const AppNavigationDrawer(),
    );
  }
}
