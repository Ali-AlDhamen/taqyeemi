import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/core.dart';
import '../../../theme/pallete.dart';
import '../controller/instructor_controller.dart';

class NewInstructorScreen extends ConsumerStatefulWidget {
  static const String routeName = '/new-instructor';
  const NewInstructorScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewInstructorScreenState();
}

class _NewInstructorScreenState extends ConsumerState<NewInstructorScreen> {
  final TextEditingController _instructorNameController =
      TextEditingController();
  final TextEditingController _instructorCollegeController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _instructorNameController.dispose();
    _instructorCollegeController.dispose();
  }

  void addInstructor() {
    if (_instructorCollegeController.text.isEmpty) {
      showSnackBar(context, 'Please select instructor college');
      return;
    }

    if (_instructorNameController.text.isEmpty) {
      showSnackBar(context, 'Please enter instructor name');
      return;
    }

    final instructorName = _instructorNameController.text;
    final instructorCollege = _instructorCollegeController.text;
    ref.read(instructorControllerProvider.notifier).addInstructor(
        instructorName: instructorName,
        instructorCollege: instructorCollege,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(instructorControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Instructor'),
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
              child: Text('Instructor name'),
            ),
            const SizedBox(height: 10),
            TextField(
              scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              controller: _instructorNameController,
              decoration: const InputDecoration(
                hintText: 'Enter instructor name',
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
              child: Text('Instructor College'),
            ),
            const SizedBox(height: 10),
            CustomRadioButton(
              elevation: 0,
              absoluteZeroSpacing: true,
              unSelectedColor: Colors.transparent,
              buttonLables: const [
                "Computer Science College",
                "Engineering College",
                "Preparatory Year"
              ],
              buttonValues: const [
                "Computer Science College",
                "Engineering College",
                "Preparatory Year"
              ],
              autoWidth: true,
              buttonTextStyle: const ButtonTextStyle(
                selectedColor: Colors.white,
                unSelectedColor: Colors.white,
                textStyle: TextStyle(fontSize: 16),
              ),
              radioButtonValue: (value) {
                _instructorCollegeController.text = value;
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
                onPressed: addInstructor,
                child: isLoading
                    ? const Loader()
                    : const Text(
                        "Add Instructor",
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
