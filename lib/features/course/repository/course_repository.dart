import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/type_defs.dart';

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

  // FutureVoid addCourse(String name) {}
}
