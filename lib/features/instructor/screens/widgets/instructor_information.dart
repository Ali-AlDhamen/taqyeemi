import 'package:flutter/material.dart';
import 'package:taqyeemi/models/instructor_model.dart';

import '../../../../core/core.dart';
import '../../../../theme/pallete.dart';
import '../instructor_screen.dart';

class InstructorInformation extends StatelessWidget {
  final Instructor instructor;
  const InstructorInformation({super.key, required this.instructor});

  void navigateToInstructorScreen(BuildContext context) {
    Navigator.pushNamed(context, InstructorScreen.routeName,
        arguments: instructor.name);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToInstructorScreen(context),
      child: Container(
        height: 75,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Pallete.grayColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  instructor.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(instructor.college,
                    style: const TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            Container(
              width: 80,
              height: 40,
              
              decoration: BoxDecoration(
                color: backGroundInstructorPrecentageColor(
                    calculateInstructor(instructor)),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  "${calculateInstructor(instructor) >= 100 ? 100 : calculateInstructor(instructor)} %",
                  style: TextStyle(
                    color: textInstructorPrecentageColor(calculateInstructor(instructor)),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
