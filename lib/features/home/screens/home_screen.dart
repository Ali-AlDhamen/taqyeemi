import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/pallete.dart';
import '../delegates/search_courses_delegate.dart';
import '../delegates/search_instructors_delegate.dart';
import '../drawers/bottom_sheet_page.dart';
import '../drawers/navigation_drawer.dart';
import '../../course/screens/courses_screen.dart';
import '../../instructor/screens/instructors_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = "/home";
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Widget _child = const CoursesScreen();

  final List<Widget> _children = [
    const CoursesScreen(),
    const InstructorsScreen(),
  ];

  void _handleNavigationChange(int index) {
    setState(() {
      _child = _children[index];
    });
  }

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              // bit darker white
              color: Color(0xffF2F2F2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.9,
            child: const BottomSheetPage());
      },
      // full screen
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taqyeemi'),
        centerTitle: false,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => displayDrawer(context),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              if (_child is CoursesScreen) {
                showSearch(
                  context: context,
                  delegate: SearchCoursesDelegate(ref),
                );
              } else {
                showSearch(
                  context: context,
                  delegate: SearchInstructorsDelegate(ref),
                );
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _child,
      bottomNavigationBar: FluidNavBar(
        style: const FluidNavBarStyle(
          barBackgroundColor: Pallete.grayColor,
          iconSelectedForegroundColor: Pallete.purpleColor,
        ),
        onChange: _handleNavigationChange,
        icons: [
          FluidNavBarIcon(
            icon: Icons.menu_book_rounded,
          ),
          FluidNavBarIcon(
            icon: Icons.people_outline_rounded,
          ),
        ],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Pallete.purpleColor,
          foregroundColor: Pallete.whiteColor,
          onPressed: () => displayBottomSheet(context),
          child: Image.asset(
            'assets/images/boty.png',
            height: 35,
            color: Pallete.whiteColor,
          )),
      drawer: const AppNavigationDrawer(),
    );
  }
}
