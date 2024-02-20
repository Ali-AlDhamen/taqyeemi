import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/core.dart';
import 'package:taqyeemi/features/instructor/screens/widgets/instructor_comment.dart';
import 'package:taqyeemi/features/instructor/screens/widgets/instructor_bar.dart';
import 'package:taqyeemi/features/instructor/screens/widgets/instructor_modal.dart';

import '../../../theme/pallete.dart';
import '../controller/instructor_controller.dart';

class InstructorScreen extends ConsumerStatefulWidget {
  static const String routeName = '/instructor';
  final String name;
  const InstructorScreen({super.key, required this.name});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InstructorScreenState();
}

class _InstructorScreenState extends ConsumerState<InstructorScreen> {
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _courseGradeController = TextEditingController();
  final TextEditingController _instructorTeachingController =
      TextEditingController();
  final TextEditingController _instructorTReatingController =
      TextEditingController();
  final TextEditingController _instructorGradingController =
      TextEditingController();
  final TextEditingController _instructorAttendanceController =
      TextEditingController();

  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _courseCodeController.dispose();
    _courseGradeController.dispose();
    _instructorTeachingController.dispose();
    _instructorTReatingController.dispose();
    _instructorGradingController.dispose();
    _instructorAttendanceController.dispose();
    _commentController.dispose();
  }

  void addComment() {
    if (_courseCodeController.text.isEmpty) {
      showSnackBar(context, 'Please enter course code');
      return;
    }

    if (_courseGradeController.text.isEmpty) {
      showSnackBar(context, 'Please enter course grade');
      return;
    }

    if (_instructorTeachingController.text.isEmpty) {
      showSnackBar(context, 'Please enter instructor teaching');
      return;
    }

    if (_instructorTReatingController.text.isEmpty) {
      showSnackBar(context, 'Please enter instructor treating');
      return;
    }

    if (_instructorGradingController.text.isEmpty) {
      showSnackBar(context, 'Please enter instructor grading');
      return;
    }

    if (_instructorAttendanceController.text.isEmpty) {
      showSnackBar(context, 'Please enter instructor attendance');
      return;
    }

    final courseCode = _courseCodeController.text;
    final courseGrade = _courseGradeController.text;
    final instructorTeaching = _instructorTeachingController.text;
    final instructorTReating = _instructorTReatingController.text;
    final instructorGrading = _instructorGradingController.text;
    final instructorAttendance = _instructorAttendanceController.text;
    final comment = _commentController.text;

    ref.read(instructorControllerProvider.notifier).addComment(
          courseGrade: courseGrade,
          instructorName: widget.name,
          comment: comment,
          teaching: int.parse(instructorTeaching),
          treating: int.parse(instructorTReating),
          grading: int.parse(instructorGrading),
          attendance: int.parse(instructorAttendance),
          courseCode: courseCode,
          context: context,
        );

    _courseCodeController.clear();
    _courseGradeController.clear();
    _instructorTeachingController.clear();
    _instructorTReatingController.clear();
    _instructorGradingController.clear();
    _instructorAttendanceController.clear();
    _commentController.clear();
  }

  void _showInputForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return InstructorModal(
          courseCodeController: _courseCodeController,
          courseGradeController: _courseGradeController,
          instructorTeachingController: _instructorTeachingController,
          instructorTReatingController: _instructorTReatingController,
          instructorGradingController: _instructorGradingController,
          instructorAttendanceController: _instructorAttendanceController,
          commentController: _commentController,
          onPressed: addComment,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(instructorControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructor'),
      ),
      body: ref.watch(instructorByNameProvider(widget.name)).when(
            data: (instructor) {
              instructor.comments.sort((a, b) => b.date.compareTo(a.date));
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
  
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Pallete.grayColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.grey)),
                                ],
                              ),
                              Container(
                                width: 100,
                                height: 50,
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
                                      fontSize: 20,
                                      color: textInstructorPrecentageColor(
                                          calculateInstructor(instructor)),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InstructorBar(
                          instructor: instructor,
                          type: "Teaching",
                        ),
                        InstructorBar(
                          instructor: instructor,
                          type: "Attitude",
                        ),
                        InstructorBar(
                          instructor: instructor,
                          type: "Grading",
                        ),
                        InstructorBar(
                          instructor: instructor,
                          type: "Attendance",
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: 200,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            color: Pallete.purpleColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _showInputForm(context);
                            },
                            child: isLoading
                                ? const Loader()
                                : const Text(
                                    "Add Rating",
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
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      reverse: false,
                      itemCount: instructor.comments.length,
                      itemBuilder: (context, index) {
                        return InstructorCommentWidget(
                          comment: instructor.comments[index],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            loading: () => const Loader(),
            error: (error, stack) => ErrorText(
              error: error.toString(),
            ),
          ),
    );
  }
}
