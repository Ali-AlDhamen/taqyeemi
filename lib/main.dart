import 'package:flutter/material.dart';
import 'package:taqyeemi/screens/sign_up_screen.dart';
import 'package:taqyeemi/theme/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Pallete.darkModeAppTheme,
      title: 'Taqyeemi',
      home: const SignUpScreen(),
    );
  }
}
