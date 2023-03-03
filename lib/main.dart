import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/screens/add_new_course_screen.dart';
import 'package:taqyeemi/screens/add_new_instructor_screen.dart';
import 'package:taqyeemi/screens/contact_screen.dart';
import 'package:taqyeemi/screens/courses_screen.dart';
import 'package:taqyeemi/screens/instructors_screen.dart';
import 'package:taqyeemi/screens/sign_in_screen.dart';
import 'package:taqyeemi/screens/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/auth/screens/login_screen.dart';
import 'firebase_options.dart';
import 'package:taqyeemi/theme/pallete.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Pallete.darkModeAppTheme,
      title: 'Taqyeemi',
      home: const LoginScreen(),
      routes: {
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        SignInScreen.routeName: (context) => const SignInScreen(),
        InstructorsScreen.routeName: (context) => const InstructorsScreen(),
        CoursesScreen.routeName: (context) => const CoursesScreen(),
        AddNewInstructorScreen.routeName: (context) => const AddNewInstructorScreen(),
        AddNewCourseScreen.routeName: (context) => const AddNewCourseScreen(),
        ContactScreen.routeName: (context) => const ContactScreen(),
        
        
      },
    );
  }
}
