import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:taqyeemi/core/common/loader.dart';
import 'package:taqyeemi/screens/instructors_screen.dart';
import 'core/common/error_text.dart';
import 'features/auth/controller/auth_controller.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/signup_screen.dart';
import 'firebase_options.dart';
import 'package:taqyeemi/theme/pallete.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey=GlobalKey<ScaffoldMessengerState>();
class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Pallete.darkModeAppTheme,
      title: 'Taqyeemi',
      home: ref.watch(authStateChangeProvider).when(
            data: (data) {
              if (data != null) {
                print(data);
                print("Radwan");
                return const InstructorsScreen();     
              }
              return const SignInScreen();
            },
            error: (error, StackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
      scaffoldMessengerKey: scaffoldMessengerKey,
      routes: {
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        SignInScreen.routeName: (context) => const SignInScreen(),
        InstructorsScreen.routeName: (context) => const InstructorsScreen()
      },
    );
  }
}
