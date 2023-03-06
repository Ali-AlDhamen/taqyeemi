import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:taqyeemi/core/common/error_text.dart';
import 'package:taqyeemi/core/common/loader.dart';
import 'package:taqyeemi/features/course/controller/course_controller.dart';
import 'package:taqyeemi/theme/pallete.dart';

import '../../../core/utils.dart';
import '../../../models/course_model.dart';

class CourseScreen extends ConsumerWidget {
  static const String routeName = '/course';
  final String name;
  const CourseScreen(this.name, {super.key});

  ValueNotifier<double> valueNotifier(Course course) {
    if (course.comments.isEmpty) {
      return ValueNotifier(0);
    }
    double sum = 0;
    for (var element in course.comments) {
      sum += calculateGrade(element.grade);
    }
    return ValueNotifier(sum / course.comments.length);
  }

  Text averageGrade(Course course) {
    if (course.comments.isEmpty) {
      return const Text("Average Grade (Unknown)");
    }
    double sum = 0;
    for (var element in course.comments) {
      sum += calculateGrade(element.grade);
    }
    // return as A+
    return courseDiffuclty(sum / course.comments.length);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: ref.watch(courseByNameProvider(name)).when(
          data: (course) {
            print(course);
            ValueNotifier<double> value = valueNotifier(course);
            return Container(
              margin: const EdgeInsets.all(10),
              height: height * 0.5,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Pallete.grayColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Pallete.greyColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(course.code,
                            style: const TextStyle(color: Colors.black)),
                      ),
                      averageGrade(course),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.book,
                    ),
                    title: Text(course.name),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.clock,
                    ),
                    title: Text("${course.creditHours} credit hours"),
                  ),
                  StepProgressIndicator(
                    padding: 0,
                    totalSteps: 100,
                    currentStep: 70,
                    size: 10,
                    selectedColor: Colors.green,
                    unselectedColor: Colors.grey,
                    roundedEdges: Radius.circular(10),
                  )
                ],
              ),
            );
          },
          error: (error, StackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader()),
    );
  }
}
