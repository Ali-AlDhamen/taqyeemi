import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

import '../../../../models/course_model.dart';
import '../../../../theme/pallete.dart';

class CourseModal extends StatelessWidget {
  final TextEditingController diffucltyController;
  final TextEditingController gradeController;
  final TextEditingController commentController;
  final void Function(Course course) addComment;
  final Course course;
  const CourseModal({
    Key? key,
    required this.diffucltyController,
    required this.gradeController,
    required this.commentController,
    required this.addComment,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text('Course Rate'),
          ),
          const SizedBox(height: 10),
          CustomRadioButton(
            autoWidth: true,
            elevation: 0,
            absoluteZeroSpacing: true,
            unSelectedColor: Colors.transparent,
            buttonLables: const [
              "Super Easy",
              "Easy",
              "Medium",
              "Hard",
              "Super Hard"
            ],
            buttonValues: const [
              "Super Easy",
              "Easy",
              "Medium",
              "Hard",
              "Super Hard"
            ],
            buttonTextStyle: const ButtonTextStyle(
                selectedColor: Colors.white,
                unSelectedColor: Colors.white,
                textStyle: TextStyle(fontSize: 12)),
            radioButtonValue: (value) {
              diffucltyController.text = value;
            },
            selectedColor: Pallete.purpleColor,
          ),
          const SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text('Course Grade'),
          ),
          const SizedBox(height: 10),
          CustomRadioButton(
            autoWidth: true,
            elevation: 0,
            absoluteZeroSpacing: true,
            unSelectedColor: Colors.transparent,
            buttonLables: const [
              "F",
              "D",
              "D+",
              "C",
              "C+",
              "B",
              "B+",
              "A",
              "A+",
            ],
            buttonValues: const [
              "F",
              "D",
              "D+",
              "C",
              "C+",
              "B",
              "B+",
              "A",
              "A+",
            ],
            buttonTextStyle: const ButtonTextStyle(
                selectedColor: Colors.white,
                unSelectedColor: Colors.white,
                textStyle: TextStyle(fontSize: 12)),
            radioButtonValue: (value) {
              gradeController.text = value;
            },
            selectedColor: Pallete.purpleColor,
          ),
          const SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text('Comment'),
          ),
          // comment text
          // create comment text area
          const SizedBox(height: 10),

          TextField(
            scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            onChanged: (value) {
              commentController.text = value;
            },
            cursorColor: Pallete.purpleColor,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Pallete.purpleColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Pallete.purpleColor, width: 1.0),
                ),
                hintText: "Enter your comment here (its optional)"),
            maxLines: 7,
            maxLength: 400,
          ),

          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              color: Pallete.purpleColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () => addComment(course),
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Pallete.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
