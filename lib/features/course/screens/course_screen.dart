import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:taqyeemi/features/course/controller/course_controller.dart';
import 'package:taqyeemi/features/course/screens/widgets/comment_card.dart';
import 'package:taqyeemi/features/course/screens/widgets/course_modal.dart';
import 'package:taqyeemi/features/course/screens/widgets/diffuclty_bar.dart';
import 'package:taqyeemi/theme/pallete.dart';

import '../../../models/course_model.dart';
import '../../../core/core.dart';

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
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(courseControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: ref.watch(courseByNameProvider(widget.name)).when(
          data: (course) {
            course.comments.sort((a, b) => b.date.compareTo(a.date));
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
        return CourseModal(
          addComment: addComment,
          course: course,
          diffucltyController: _diffucltyController,
          gradeController: _gradeController,
          commentController: _commentController,
        );
      },
    );
  }
}
