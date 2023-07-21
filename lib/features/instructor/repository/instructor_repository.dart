import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taqyeemi/models/instructor_comment_model.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/types/failure.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/types/type_defs.dart';
import '../../../models/instructor_model.dart';

final instructorRepositoryProvider = Provider((ref) {
  return InstructorRepository(firestore: ref.watch(firestoreProvider));
});

class InstructorRepository {
  final FirebaseFirestore _firestore;
  InstructorRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _instructor =>
      _firestore.collection(FirebaseConstants.instructorsCollection);

  FutureVoid addInstructor(Instructor instructor) async {
    try {
      var courseDoc = await _instructor.doc(instructor.name).get();
      if (courseDoc.exists) {
        throw 'instructor with the same name already exists!';
      }

      return Right(_instructor.doc(instructor.name).set(instructor.toMap()));
    } on FirebaseException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Stream<List<Instructor>> getInstructors() {
    return _instructor.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Instructor.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<Instructor> getInstructorByName(String name) {
    return _instructor.doc(name).snapshots().map((snapshot) {
      return Instructor.fromMap(snapshot.data() as Map<String, dynamic>);
    });
  }

  FutureVoid addComment(InstructorComment comment) async {
    try {
      return right(_instructor.doc(comment.instructorId).update({
        'comments': FieldValue.arrayUnion([comment.toMap()])
      }));
    } on FirebaseException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Instructor>> searchInstructor(String query) {
    return _instructor
        .where(
          'name',
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
        return Instructor.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  
}
