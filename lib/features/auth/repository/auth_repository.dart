import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taqyeemi/core/failure.dart';
import 'package:taqyeemi/core/type_defs.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../models/user_model.dart';


final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthRepository(
      {required FirebaseFirestore firestore, required FirebaseAuth auth})
      : _firestore = firestore,
        _auth = auth;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureEither<UserModel> signUpWithEmail(
      {required String email,
      required String password,
      required String name,
      required String phoneNumber}) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final userId = authResult.user!.uid;

      UserModel userModel = UserModel(
          name: name, email: email, phoneNumber: phoneNumber, userId: userId);
      await _users.doc(userId).set(userModel.toMap());

      return Right(userModel);
    // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> signInWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final userId = authResult.user!.uid;


      UserModel userModel = await getUserData(userId).first;

      return Right(userModel);
    // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map((event) {
      return UserModel.fromMap(event.data() as Map<String , dynamic>);
    });
  }

  void logout() async {
    await _auth.signOut();
  }
}
