import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NewCourseScreen extends ConsumerWidget {
  static const String routeName = '/new-course';
  const NewCourseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Course'),
      ),
      body: Container(),
    );
  }
}