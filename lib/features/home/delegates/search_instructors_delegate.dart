import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/features/instructor/controller/instructor_controller.dart';
import 'package:taqyeemi/features/instructor/screens/instructor_screen.dart';

import '../../../core/core.dart';

class SearchInstructorsDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchInstructorsDelegate(this.ref);
  @override
  String get searchFieldLabel => 'Search Instructors by Name';

  void navigateToCourse(String instructorName, BuildContext context) {
    Navigator.pushNamed(context, InstructorScreen.routeName, arguments: instructorName);
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
     return ref.watch(searchInstructorProvider(query)).when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => navigateToCourse(data[index].name, context),
                  title: Text(data[index].name),
                  subtitle: Text(data[index].college),
                );
              },
            );
          },
          loading: () => const Loader(),
          error: (error, stack) => const SizedBox(),
        );
  }
}
