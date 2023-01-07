import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../widgets/NavigationDrawer.dart';

class InstructorsScreen extends StatefulWidget {
  static const String routeName = "/instructors_screen";

  const InstructorsScreen({super.key});

  
  @override
  State<InstructorsScreen> createState() => _InstructorsScreenState();
}

class _InstructorsScreenState extends State<InstructorsScreen> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: NavigationDrawer(),
      body:  Column(
        children: [
          const Text('Welcome to Home Screen'),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text('Sign Out'),
          ),
        ],
      )
    );
  }
}
