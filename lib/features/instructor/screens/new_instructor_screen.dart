import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NewInstructorScreen extends ConsumerWidget {
  static const String routeName = '/new-instructor';
  const NewInstructorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Instructor'),
      ),
      body: Container(),
    );
  }
}