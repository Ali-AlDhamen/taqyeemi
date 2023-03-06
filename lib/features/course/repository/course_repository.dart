import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/failure.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/type_defs.dart';
import '../../../models/course_comment_model.dart';
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

  FutureVoid addCourse(Course course) async {
    try {
      var courseDoc = await _courses.doc(course.name).get();
      if (courseDoc.exists) {
        throw 'course with the same name already exists!';
      }

      return right(_courses.doc(course.name).set(course.toMap()));
    } on FirebaseException catch (e) {
      return Left(Failure(e.toString()));
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

  FutureVoid addComment(CourseComment comment, String courseName) async {
    try {
      return right(_courses.doc(courseName).update({
        'comments': FieldValue.arrayUnion([comment.toMap()])
      }));
    } on FirebaseException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<CourseComment>> getComments(String courseName) {
    return _courses.doc(courseName).snapshots().map((snapshot) {
      return (snapshot.data() as Map<String, dynamic>)['comments']
          .map<CourseComment>((comment) {
        return CourseComment.fromMap(comment as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<Course>> searchCourses(String query) {
    return _courses
        .where(
          'code',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Course.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}