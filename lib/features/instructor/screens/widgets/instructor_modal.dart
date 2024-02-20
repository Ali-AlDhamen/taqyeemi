import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/core.dart';
import 'package:taqyeemi/features/instructor/controller/instructor_controller.dart';

import '../../../../theme/pallete.dart';



class InstructorModal extends ConsumerWidget {
  final TextEditingController courseCodeController;
  final TextEditingController courseGradeController;
  final TextEditingController instructorTeachingController;
  final TextEditingController instructorTReatingController;
  final TextEditingController instructorGradingController;
  final TextEditingController instructorAttendanceController;
  final TextEditingController commentController;
  final void Function()? onPressed;

  const InstructorModal({super.key, 
    required this.courseCodeController,
    required this.courseGradeController,
    required this.instructorTeachingController,
    required this.instructorTReatingController,
    required this.instructorGradingController,
    required this.instructorAttendanceController,
    required this.commentController,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final isLoading = ref.watch(instructorControllerProvider);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text('Course Code'),
            ),
            const SizedBox(height: 10),
            TextField(
              scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              controller: courseCodeController,
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
                  hintText: "Enter course code e.g CS101"),
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
                courseGradeController.text = value;
              },
              selectedColor: Pallete.purpleColor,
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text('Instructor Teaching'),
            ),
            const SizedBox(height: 10),
            CustomRadioButton(
              autoWidth: true,
              elevation: 0,
              absoluteZeroSpacing: true,
              unSelectedColor: Colors.transparent,
              buttonLables: const [
                "10",
                "20",
                "30",
                "40",
                "50",
                "60",
                "70",
                "80",
                "90",
                "100",
              ],
              buttonValues: const [
                "10",
                "20",
                "30",
                "40",
                "50",
                "60",
                "70",
                "80",
                "90",
                "100",
              ],
              buttonTextStyle: const ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.white,
                  textStyle: TextStyle(fontSize: 12)),
              radioButtonValue: (value) {
                instructorTeachingController.text = value;
              },
              selectedColor: Pallete.purpleColor,
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text('Instructor Attitude'),
            ),
            const SizedBox(height: 10),
            CustomRadioButton(
              autoWidth: true,
              elevation: 0,
              absoluteZeroSpacing: true,
              unSelectedColor: Colors.transparent,
              buttonLables: const [
                "10",
                "20",
                "30",
                "40",
                "50",
                "60",
                "70",
                "80",
                "90",
                "100",
              ],
              buttonValues: const [
                "10",
                "20",
                "30",
                "40",
                "50",
                "60",
                "70",
                "80",
                "90",
                "100",
              ],
              buttonTextStyle: const ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.white,
                  textStyle: TextStyle(fontSize: 12)),
              radioButtonValue: (value) {
                instructorTReatingController.text = value;
              },
              selectedColor: Pallete.purpleColor,
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text('Instructor Grading'),
            ),
            const SizedBox(height: 10),
            CustomRadioButton(
              autoWidth: true,
              elevation: 0,
              absoluteZeroSpacing: true,
              unSelectedColor: Colors.transparent,
              buttonLables: const [
                "10",
                "20",
                "30",
                "40",
                "50",
                "60",
                "70",
                "80",
                "90",
                "100",
              ],
              buttonValues: const [
                "10",
                "20",
                "30",
                "40",
                "50",
                "60",
                "70",
                "80",
                "90",
                "100",
              ],
              buttonTextStyle: const ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.white,
                  textStyle: TextStyle(fontSize: 12)),
              radioButtonValue: (value) {
                instructorGradingController.text = value;
              },
              selectedColor: Pallete.purpleColor,
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text('Instructor Attendance'),
            ),
            const SizedBox(height: 10),
            CustomRadioButton(
              autoWidth: true,
              elevation: 0,
              absoluteZeroSpacing: true,
              unSelectedColor: Colors.transparent,
              buttonLables: const [
                "10",
                "20",
                "30",
                "40",
                "50",
                "60",
                "70",
                "80",
                "90",
                "100",
              ],
              buttonValues: const [
                "10",
                "20",
                "30",
                "40",
                "50",
                "60",
                "70",
                "80",
                "90",
                "100",
              ],
              buttonTextStyle: const ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.white,
                  textStyle: TextStyle(fontSize: 12)),
              radioButtonValue: (value) {
                instructorAttendanceController.text = value;
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
              controller: commentController,
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
                onPressed: onPressed,
                child: isLoading ? const Loader() : const Text(
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
      ),
    );
  }
}
