import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils.dart';
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
    required int teaching,
    required int grading,
    required int treating,
    required int attendance,
    required BuildContext context,
  }) async {
    state = true;
    final userId = _ref.read(userProvider)!.userId;
    InstructorComment instructorComment = InstructorComment(
        id: const Uuid().v4(),
        instructorId: instructorName,
        userId: userId,
        comment: comment,
        teaching: teaching,
        grading: grading,
        treating: treating,
        attendance: attendance,
        date: DateTime.now());

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
}
