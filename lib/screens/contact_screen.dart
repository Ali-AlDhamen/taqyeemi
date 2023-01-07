import 'package:flutter/material.dart';

import '../widgets/NavigationDrawer.dart';


class ContactScreen extends StatelessWidget {
  static const String routeName = "/contact_screen";
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Contact'),
      ),
      drawer: NavigationDrawer(),
      body: const Center(
        child: Text('Contact Screen'),
      ),
    );
  }
}