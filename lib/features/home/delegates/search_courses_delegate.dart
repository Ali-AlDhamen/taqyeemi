import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/features/course/controller/course_controller.dart';
import 'package:taqyeemi/features/course/screens/course_screen.dart';

import '../../../core/core.dart';

class SearchCoursesDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchCoursesDelegate(this.ref);
  @override
  String get searchFieldLabel => 'Search Courses by Code';

  void navigateToCourse(String courseName, BuildContext context) {
    Navigator.pushNamed(context, CourseScreen.routeName, arguments: courseName);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
   
  }

  @override
  Widget buildSuggestions(BuildContext context) {
     return ref.watch(searchCoursesProvider(query)).when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => navigateToCourse(data[index].name, context),
                  title: Text(data[index].code),
                  subtitle: Text(data[index].name),
                );
              },
            );
          },
          loading: () => const Loader(),
          error: (error, stack) => const SizedBox(),
        );
  }
}
