import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              child: Expanded(
            child: Column(
              children: [
                Image.asset("assets/images/logo.png", width: 200, height: 100),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
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
          )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // make list tiles for instructors , subjects , add new instructor , add new subject , contact us , log out
                ListTile(
                  leading: const Icon(Icons.people_outline),
                  title: const Text('Instructors'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                

                ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: const Text('Courses'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.person_add_alt_outlined),
                  title: const Text('Add New Instructor'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_circle_outline),
                  title: const Text('Add New Course'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_support_outlined),
                  title: const Text('Contact Us'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Log Out'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
