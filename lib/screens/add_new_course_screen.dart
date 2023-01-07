import 'package:flutter/material.dart';

class AddNewCourseScreen extends StatelessWidget {
  static const String routeName = "/add_new_course";
  const AddNewCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Course'),
      ),
      body: const Center(
        child: Text('Add New Course Screen'),
      ),
    );
  }
}