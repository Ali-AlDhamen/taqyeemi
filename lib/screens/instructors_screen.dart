import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/features/auth/controller/auth_controller.dart';

import '../models/user_model.dart';
import '../widgets/NavigationDrawer.dart';

class InstructorsScreen extends ConsumerStatefulWidget {
  static const String routeName = "/instructors_screen";
  const InstructorsScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InstructorsScreenState();
}

class _InstructorsScreenState extends ConsumerState<InstructorsScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel? user = ref.watch(userProvider);
    print(user.toString());

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        drawer: const AppNavigationDrawer(),
        body: Column(
          children: [
            Text(user?.email ?? "No Email"),
            ElevatedButton(
              onPressed: () async {
                ref.read(authControllerProvider.notifier).logout(context);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ));
  }
}
