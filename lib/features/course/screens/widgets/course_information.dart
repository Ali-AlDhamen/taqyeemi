import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:taqyeemi/features/course/screens/course_screen.dart';

import '../../../../core/core.dart';
import '../../../../models/course_model.dart';
import '../../../../theme/pallete.dart';

class CourseInformation extends StatelessWidget {
  final Course course;

  const CourseInformation({Key? key, required this.course}) : super(key: key);

  void navigateToCourseScreen(BuildContext context) {
    Navigator.pushNamed(context, CourseScreen.routeName,
        arguments: course.name);
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<double> value = valueNotifier(course);
    return GestureDetector(
      onTap: () => navigateToCourseScreen(context),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Pallete.grayColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 195,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(course.code,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(),
                  const SizedBox(),
                  SizedBox(
                    width: 55,
                    height: 55,
                    child: SimpleCircularProgressBar(
                      progressColors: [gradeColor(value.value.toDouble())],
                      valueNotifier: value,
                      mergeMode: true,
                      animationDuration: 3,
                      progressStrokeWidth: 5,
                      backStrokeWidth: 5,
                      onGetText: (p0) {
                        return courseDiffuclty(p0);
                      },
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.book,
                ),
                title: Text(course.name),
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.clock,
                ),
                title: Text("${course.creditHours} credit hours"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
