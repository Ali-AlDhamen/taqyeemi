import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/features/course/controller/course_controller.dart';
import 'package:taqyeemi/features/course/screens/widgets/course_information.dart';

import '../../../core/core.dart';

class CoursesScreen extends ConsumerWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          ref.watch(coursesProvider).when(
                data: (courses) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return CourseInformation(
                          course: courses[index],
                        );
                      },
                    ),
                  );
                },
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
                loading: () => const Loader(),
              )
        ],
      ),
    );
  }
}
