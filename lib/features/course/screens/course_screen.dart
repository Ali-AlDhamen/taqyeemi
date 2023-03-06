import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:taqyeemi/core/common/error_text.dart';
import 'package:taqyeemi/core/common/loader.dart';
import 'package:taqyeemi/features/course/controller/course_controller.dart';
import 'package:taqyeemi/features/course/screens/widgets/diffuclty_bar.dart';
import 'package:taqyeemi/models/course_diffuclty_model.dart';
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

  List<CourseDiffuclty> diffucltyOverTotal(Course course) {
    if (course.comments.isEmpty) {
      return [
        CourseDiffuclty(
            diffuclty: "Super Easy", precentage: 0, color: Colors.green),
        CourseDiffuclty(diffuclty: "Easy", precentage: 0, color: Colors.green),
        CourseDiffuclty(
            diffuclty: "Medium", precentage: 0, color: Colors.yellow),
        CourseDiffuclty(diffuclty: "Hard", precentage: 0, color: Colors.red),
        CourseDiffuclty(
            diffuclty: "Super Hard", precentage: 0, color: Colors.red),
      ];
    }
    double superEasy = 0;
    double easy = 0;
    double medium = 0;
    double hard = 0;
    double superHard = 0;
    for (var element in course.comments) {
      if (element.difficulty == "Super Easy") {
        superEasy++;
      } else if (element.difficulty == "Easy") {
        easy++;
      } else if (element.difficulty == "Medium") {
        medium++;
      } else if (element.difficulty == "Hard") {
        hard++;
      } else if (element.difficulty == "Super Hard") {
        superHard++;
      }
    }

    return [
      CourseDiffuclty(
          diffuclty: "Super Easy",
          precentage: superEasy / course.comments.length,
          color: Colors.green),
      CourseDiffuclty(
          diffuclty: "Easy",
          precentage: easy / course.comments.length,
          color: Colors.green),
      CourseDiffuclty(
          diffuclty: "Medium",
          precentage: medium / course.comments.length,
          color: Colors.yellow),
      CourseDiffuclty(
          diffuclty: "Hard",
          precentage: hard / course.comments.length,
          color: Colors.red),
      CourseDiffuclty(
          diffuclty: "Super Hard",
          precentage: superHard / course.comments.length,
          color: Colors.red),
    ];
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
                  ...diffucltyOverTotal(course).map((e) => DifficultyBar(e)).toList(),
               
                ],
              ),
            );
          },
          error: (error, StackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader()),
    );
  }
}
