import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/core.dart';
import '../../../models/instructor_comment_model.dart';
import '../../../models/instructor_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/instructor_repository.dart';

final instructorControllerProvider =
    StateNotifierProvider<InstructorController, bool>((ref) {
  return InstructorController(
    instructorRepository: ref.watch(instructorRepositoryProvider),
    ref: ref,
  );
});

final instructorByNameProvider = StreamProvider.family((ref, String name) {
  return ref
      .watch(instructorControllerProvider.notifier)
      .getInstructorByName(name);
});
final instructorsProvider = StreamProvider(
  (ref) => ref.watch(instructorControllerProvider.notifier).getInstructors(),
);

final searchInstructorProvider = StreamProvider.family((ref, String query) {
  return ref
      .watch(instructorControllerProvider.notifier)
      .searchInstructors(query);
});

class InstructorController extends StateNotifier<bool> {
  final InstructorRepository _instructorRepository;
  final Ref _ref;

  InstructorController(
      {required InstructorRepository instructorRepository, required Ref ref})
      : _instructorRepository = instructorRepository,
        _ref = ref,
        super(false);

  void addInstructor({
    required String instructorName,
    required String instructorCollege,
    required BuildContext context,
  }) async {
    state = true;
    Instructor instructor = Instructor(
      id: instructorName,
      name: instructorName,
      college: instructorCollege,
      comments: [],
    );
    await Future.delayed(const Duration(seconds: 2));

    final result = await _instructorRepository.addInstructor(instructor);
    state = false;
    result.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        Navigator.pop(context);
      },
    );
  }

  void addComment({
    required String instructorName,
    required String? comment,
    required String courseGrade,
    required int teaching,
    required int grading,
    required int treating,
    required int attendance,
    required String courseCode,
    required BuildContext context,
  }) async {
    state = true;
    final userId = _ref.read(userProvider)!.userId;
    InstructorComment instructorComment = InstructorComment(
      id: const Uuid().v4(),
      instructorId: instructorName,
      userId: userId,
      courseGrade: courseGrade,
      comment: comment,
      teaching: teaching,
      grading: grading,
      treating: treating,
      attendance: attendance,
      courseCode: courseCode,
      date: DateTime.now(),
    );


    final result = await _instructorRepository.addComment(instructorComment);
    state = false;
    result.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        Navigator.pop(context);
      },
    );
  }

  Stream<List<Instructor>> getInstructors() {
    return _instructorRepository.getInstructors();
  }

  Stream<List<Instructor>> searchInstructors(String query) {
    return _instructorRepository.searchInstructor(query);
  }

  Stream<Instructor> getInstructorByName(String name) {
    return _instructorRepository.getInstructorByName(name);
  }

  Future<String> getInstructorsDataFormatted() {
    state = true;
    final data = _instructorRepository.getInstructorsDataFormatted();
    state = false;
    return data;
  }
}
