import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:taqyeemi/core/core.dart';
import 'package:taqyeemi/models/instructor_model.dart';

class InstructorBar extends StatelessWidget {
  final Instructor instructor;
  final String type;
  const InstructorBar({
    super.key,
    required this.instructor,
    required this.type,
  });

  int getPercentage() {
    if (instructor.comments.isEmpty) {
      return 0;
    }
    switch (type) {
      case "Teaching":
        int result = 0;
        for (var element in instructor.comments) {
          result += element.teaching;
        }

        return result ~/ instructor.comments.length;
      case "Treating":
        int result = 0;
        for (var element in instructor.comments) {
          result += element.treating;
        }
        return result ~/ instructor.comments.length;
      case "Grading":
        int result = 0;
        for (var element in instructor.comments) {
          result += element.grading;
        }
        return result ~/ instructor.comments.length;
      case "Attendance":
        int result = 0;
        for (var element in instructor.comments) {
          result += element.attendance;
        }
        return result ~/ instructor.comments.length;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 80,
            child: Text(type),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: StepProgressIndicator(
                      padding: 0,
                      totalSteps: 100,
                      currentStep: getPercentage(),
                      size: 15,
                      selectedColor:
                          textInstructorPrecentageColor(getPercentage() + 0.0),
                      unselectedColor: Colors.grey,
                      roundedEdges: const Radius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${getPercentage()} %",
                  style: TextStyle(
                    color: textInstructorPrecentageColor(getPercentage() + 0.0),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
