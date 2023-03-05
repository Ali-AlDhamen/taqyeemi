import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/failure.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/type_defs.dart';
import '../../../models/course_model.dart';

final courseRepositoryProvider = Provider((ref) {
  return CourseRepository(firestore: ref.watch(firestoreProvider));
});

class CourseRepository {
  final FirebaseFirestore _firestore;
  CourseRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _courses =>
      _firestore.collection(FirebaseConstants.coursesCollection);

  CollectionReference get _comments =>
      _firestore.collection(FirebaseConstants.coursesCommentsCollection);

  FutureVoid addCourse(Course course) async {
    try {
      var courseDoc = await _courses.doc(course.name).get();
      if (courseDoc.exists) {
        throw 'course with the same name already exists!';
      }

      return right(_courses.doc(course.name).set(course.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Course>> getCourses() {
    return _courses.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Course.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<Course> getCourseByName(String name) {
    return _courses.doc(name).snapshots().map((snapshot) {
      return Course.fromMap(snapshot.data() as Map<String, dynamic>);
    });
  }

}
