import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:taqyeemi/screens/instructors_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/signup_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: SignInScreen()),
  '/sign_up_screen': (_) => const MaterialPage(
        child: SignUpScreen(),
      )
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: InstructorsScreen()),
});