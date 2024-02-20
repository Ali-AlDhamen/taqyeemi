import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/features/course/repository/course_repository.dart';

import '../../../core/core.dart';
import '../../../models/course_comment_model.dart';
import '../../../models/course_model.dart';
import '../../auth/controller/auth_controller.dart';

final courseControllerProvider =
    StateNotifierProvider<CourseController, bool>((ref) {
  return CourseController(
    courseRepository: ref.watch(courseRepositoryProvider),
    ref: ref,
  );
});

final courseByNameProvider = StreamProvider.family((ref, String name) {
  return ref.watch(courseControllerProvider.notifier).getCourseByName(name);
});

final coursesProvider = StreamProvider((ref) {
  return ref.watch(courseControllerProvider.notifier).getCourses();
});

final searchCoursesProvider = StreamProvider.family((ref, String query) {
  return ref.watch(courseControllerProvider.notifier).searchCourses(query);
});

class CourseController extends StateNotifier<bool> {
  final CourseRepository _courseRepository;
  final Ref _ref;
  CourseController(
      {required CourseRepository courseRepository, required Ref ref})
      : _courseRepository = courseRepository,
        _ref = ref,
        super(false);

  void addCourse(
      {required String courseName,
      required String courseCode,
      required int courseCreditHours,
      required BuildContext context}) async {
    state = true;
    Course course = Course(
        id: courseCode,
        code: courseCode,
        name: courseName,
        creditHours: courseCreditHours,
        comments: []);

    final result = await _courseRepository.addCourse(course);
    state = false;
    result.fold((l) => showSnackBar(context, l.message), (r) {
      Navigator.pop(context);
    });
  }

  Stream<List<Course>> getCourses() {
    return _courseRepository.getCourses();
  }

  Stream<Course> getCourseByName(String name) {
    return _courseRepository.getCourseByName(name);
  }

  void addComment(String grade, String comment, String diffuclty, Course course,
      BuildContext context) async {
    state = true;

    final user = _ref.read(userProvider)!;

    CourseComment courseComment = CourseComment(
      id: "${course.name}${DateTime.now()}",
      comment: comment,
      difficulty: diffuclty,
      grade: grade,
      userId: user.userId,
      courseId: course.id,
      date: DateTime.now(),
    );

    final result =
        await _courseRepository.addComment(courseComment, course.name);
    state = false;

    result.fold((l) => showSnackBar(context, l.message), (r) {
      Navigator.pop(context);
    });
  }

  Stream<List<Course>> searchCourses(String query) {
    return _courseRepository.searchCourses(query);
  }

  Future<String> getCoursesDataFormatted() async {
    state = true;
    final data = await _courseRepository.getCoursesDataFormatted();
    state = false;
    return data;
  }
}
