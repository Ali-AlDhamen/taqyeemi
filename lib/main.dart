import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/core.dart';
import 'features/auth/controller/auth_controller.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/course/screens/course_screen.dart';
import 'features/course/screens/new_course_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'features/instructor/screens/instructor_screen.dart';
import 'features/instructor/screens/new_instructor_screen.dart';
import 'firebase_options.dart';
import 'models/user_model.dart';
import 'theme/pallete.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Pallete.darkModeAppTheme,
      title: 'Taqyeemi',
      home: ref.watch(authStateChangeProvider).when(
            data: (data) {
              if (data != null) {
                getData(ref, data);
                return const HomeScreen();
              }
              return const SignInScreen();
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
      routes: {
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        SignInScreen.routeName: (context) => const SignInScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        NewInstructorScreen.routeName: (context) => const NewInstructorScreen(),
        NewCourseScreen.routeName: (context) => const NewCourseScreen(),
        CourseScreen.routeName: (context) =>
            CourseScreen(ModalRoute.of(context)!.settings.arguments as String),
        InstructorScreen.routeName: (context) => InstructorScreen(
            name: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}
