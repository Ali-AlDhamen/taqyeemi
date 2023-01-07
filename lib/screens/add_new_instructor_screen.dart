import 'package:flutter/material.dart';

class AddNewInstructorScreen extends StatelessWidget {
  static const String routeName = "/add_new_instructor";
  const AddNewInstructorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Instructor'),
      ),
      body: const Center(
        child: Text('Add New Instructor Screen'),
      ),
    );
  }
}