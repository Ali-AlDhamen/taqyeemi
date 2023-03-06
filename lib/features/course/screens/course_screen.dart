import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:taqyeemi/core/common/error_text.dart';
import 'package:taqyeemi/core/common/loader.dart';
import 'package:taqyeemi/features/course/controller/course_controller.dart';
import 'package:taqyeemi/features/course/screens/widgets/comment_card.dart';
import 'package:taqyeemi/features/course/screens/widgets/diffuclty_bar.dart';
import 'package:taqyeemi/theme/pallete.dart';

import '../../../core/utils.dart';
import '../../../models/course_model.dart';

class CourseScreen extends ConsumerStatefulWidget {
  static const String routeName = '/course';
  final String name;
  const CourseScreen(this.name, {super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CourseScreenState();
}

class _CourseScreenState extends ConsumerState<CourseScreen> {
  final TextEditingController _diffucltyController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _gradeController.dispose();
    _commentController.dispose();
    _diffucltyController.dispose();
  }

  void addComment(Course course) {
    ref.read(courseControllerProvider.notifier).addComment(
        _gradeController.text.trim(),
        _commentController.text.trim(),
        _diffucltyController.text.trim(),
        course,
        context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: ref.watch(courseByNameProvider(widget.name)).when(
          data: (course) {
            return Column(
              children: [
                Container(
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
                      ),
                      ...diffucltyOverTotal(course)
                          .map((e) => DifficultyBar(e))
                          .toList(),
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
                          onPressed: () => _showInputForm(context, course),
                          child: const Text(
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
                    itemCount: course.comments.length,
                    itemBuilder: (context, index) {
                      return CommentCard(
                        comment: course.comments[index],
                      );
                    },
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader()),
    );
  }

  void _showInputForm(BuildContext context, Course course) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
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
                  _diffucltyController.text = value;
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
                  _gradeController.text = value;
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
                onChanged: (value) {
                  _commentController.text = value;
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
                  onPressed: () {
                    addComment(course);
                  },
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
      },
    );
  }
}
