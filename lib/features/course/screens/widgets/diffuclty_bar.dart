import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../models/course_diffuclty_model.dart';

class DifficultyBar extends StatelessWidget {
  CourseDiffuclty diffuclty;
  DifficultyBar(this.diffuclty, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(diffuclty.diffuclty),
          const SizedBox(width: 10),
          SizedBox(
            width: 300,
            child: StepProgressIndicator(
              padding: 0,
              totalSteps: 100,
              currentStep: (diffuclty.precentage ).toInt(),
              size: 15,
              selectedColor: Colors.green,
              unselectedColor: Colors.grey,
              roundedEdges:  const Radius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
