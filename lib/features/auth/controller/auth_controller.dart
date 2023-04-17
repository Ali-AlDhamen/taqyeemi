import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../../../models/user_model.dart';
import '../repository/auth_repository.dart';


final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);
final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void signUpWithEmail(
      {required String email,
      required String password,
      required String name,
      required String phoneNumber,
      required BuildContext context}) async {
    state = true;
    final user = await _authRepository.signUpWithEmail(
        email: email, password: password, name: name, phoneNumber: phoneNumber);

    state = false;
    user.fold(
        (l) => showSnackBar(
              context,
              l.message,
            ), (userModel) {
      _ref.read(userProvider.notifier).update((state) => userModel);
      Navigator.pop(context);
    });
  }

  void signInWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final user =
        await _authRepository.signInWithEmail(email: email, password: password);

    state = false;
    user.fold(
        (l) => showSnackBar(
              context,
              l.message,
            ),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }

  void logout() {
    _authRepository.logout();
    _ref.read(userProvider.notifier).update((state) => null);
  }
}
