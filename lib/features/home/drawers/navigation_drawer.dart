import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controller/auth_controller.dart';
import '../../course/screens/new_course_screen.dart';
import '../../instructor/screens/new_instructor_screen.dart';

class AppNavigationDrawer extends ConsumerWidget {
  const AppNavigationDrawer({super.key});

  void logout(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  void navigateToNewCourse(BuildContext context) {
    Navigator.pushNamed(context, NewCourseScreen.routeName);
  }

  void navigateToNewInstructor(BuildContext context) {
    Navigator.pushNamed(context, NewInstructorScreen.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Image.asset("assets/images/logo.png", width: 200, height: 100),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Text(
                    "Taqyeemi",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                    leading: const Icon(Icons.person_add_alt_outlined),
                    title: const Text('Add New Instructor'),
                    onTap: () => navigateToNewInstructor(context)),
                ListTile(
                  leading: const Icon(Icons.add_circle_outline),
                  title: const Text('Add New Course'),
                  onTap: () => navigateToNewCourse(context),
                ),
                // ListTile(
                //   leading: const Icon(Icons.contact_support_outlined),
                //   title: const Text('Contact Us'),
                //   onTap: () {
                //     Navigator.pushReplacementNamed(
                //         context, ContactScreen.routeName);
                //   },
                // ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Log Out'),
                  onTap: () => logout(ref),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
