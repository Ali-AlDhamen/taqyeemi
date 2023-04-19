import 'package:flutter/material.dart';

class GradeContainer extends StatelessWidget {
  final Text text;
  final Color color;

  const GradeContainer({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: text,
      ),
    );
  }
}
