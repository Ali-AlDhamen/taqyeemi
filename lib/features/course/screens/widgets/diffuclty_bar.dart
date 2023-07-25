import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../models/course_diffuclty_model.dart';

class DifficultyBar extends StatelessWidget {
  final CourseDiffuclty diffuclty;
  const DifficultyBar(this.diffuclty, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Text(diffuclty.diffuclty)),
      
          Expanded(
            child: SizedBox(
              
              child: StepProgressIndicator(
                padding: 0,
                totalSteps: 100,
                currentStep: (diffuclty.precentage * 100).toInt(),
                size: 15,
                selectedColor: diffuclty.color,
                unselectedColor: Colors.grey,
                roundedEdges: const Radius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
