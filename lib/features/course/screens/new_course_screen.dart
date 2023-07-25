import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/features/course/controller/course_controller.dart';

import '../../../core/core.dart';
import '../../../theme/pallete.dart';

class NewCourseScreen extends ConsumerStatefulWidget {
  static const String routeName = '/new-course';
  const NewCourseScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewCourseScreenState();
}

class _NewCourseScreenState extends ConsumerState<NewCourseScreen> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _courseCreditHoursController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _courseNameController.dispose();
    _courseCodeController.dispose();
    _courseCreditHoursController.dispose();
  }

  void addCourse() {
    final courseName = _courseNameController.text;
    final courseCode = _courseCodeController.text;
    final courseCreditHours = _courseCreditHoursController.text;
    ref.read(courseControllerProvider.notifier).addCourse(
        courseName: courseName,
        courseCode: courseCode,
        courseCreditHours: int.parse(courseCreditHours),
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(courseControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Course'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Course name'),
              ),
              const SizedBox(height: 10),
              TextField(
                scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                controller: _courseNameController,
                decoration: const InputDecoration(
                  hintText: 'course name e.g intro to programming',
                  filled: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(18),
                ),
                maxLength: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Course code'),
              ),
              const SizedBox(height: 10),
              TextField(
                scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                controller: _courseCodeController,
                decoration: const InputDecoration(
                  hintText: 'course code e.g CS101',
                  filled: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(18),
                ),
                maxLength: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Course Credit Hours'),
              ),
              const SizedBox(height: 10),
              CustomRadioButton(
                elevation: 0,
                absoluteZeroSpacing: true,
                unSelectedColor: Colors.transparent,
                buttonLables: const [
                  "1",
                  "2",
                  "3",
                  "4",
                  "5",
                  "6",
                  "7",
                  "8",
                  "9",
                  "10",
                ],
                buttonValues: const [
                  "1",
                  "2",
                  "3",
                  "4",
                  "5",
                  "6",
                  "7",
                  "8",
                  "9",
                  "10",
                ],
                buttonTextStyle: const ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: Colors.white,
                    textStyle: TextStyle(fontSize: 16)),
                radioButtonValue: (value) {
                  _courseCreditHoursController.text = value;
                },
                selectedColor: Pallete.purpleColor,
              ),
              const SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: Pallete.purpleColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: addCourse,
                  child: isLoading
                      ? const Loader()
                      : const Text(
                          "Add Course",
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
        ));
  }
}
