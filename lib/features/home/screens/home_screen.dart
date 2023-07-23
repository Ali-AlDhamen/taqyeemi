import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/features/gpt/repository/gpt_repository.dart';

import '../../../theme/pallete.dart';
import '../delegates/search_courses_delegate.dart';
import '../delegates/search_instructors_delegate.dart';
import '../../gpt/screens/taqyeemigpt_screen.dart';
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

  void loadData() {
    Future.delayed(
      const Duration(seconds: 1),
      () => ref.read(gptRepositoryProvider).taqyeemiGPTInit(),
    );
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

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
        return const TaqyeemiGPTScreen();
      },
      isScrollControlled: true,
    );
  }

  void handleSearch() {
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
            onPressed: () => handleSearch(),
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
