import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/features/instructor/controller/instructor_controller.dart';
import 'package:taqyeemi/features/instructor/screens/widgets/instructor_information.dart';

import '../../../core/core.dart';

class InstructorsScreen extends ConsumerWidget {
  const InstructorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          ref.watch(instructorsProvider).when(
                data: (instructors) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: instructors.length,
                      itemBuilder: (context, index) {
                        return InstructorInformation(
                          instructor: instructors[index],
                        );
                      },
                    ),
                  );
                },
                error: (error, stackTrace) =>
                    ErrorText(error: stackTrace.toString()),
                loading: () => const Loader(),
              ),
        ],
      ),
    );
  }
}
