import 'package:flutter/material.dart';

import '../widgets/NavigationDrawer.dart';

class CoursesScreen extends StatelessWidget {
  static const String routeName = "/courses_screen";
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Courses'),
      ),
      drawer: NavigationDrawer(),
      body: const Center(
        child: Text('Courses Screen'),
      ),
    );
  }
}
