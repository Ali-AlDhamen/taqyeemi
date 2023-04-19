import 'package:flutter/material.dart';

class CourseDiffuclty {
  final String diffuclty;
  final double precentage;
  final Color color;
  CourseDiffuclty({
    required this.diffuclty,
    required this.precentage,
    required this.color,
  });


  CourseDiffuclty copyWith({
    String? diffuclty,
    double? precentage,
    MaterialColor? color,
  }) {
    return CourseDiffuclty(
      diffuclty: diffuclty ?? this.diffuclty,
      precentage: precentage ?? this.precentage,
      color: color ?? this.color,
    );
  }


  @override
  String toString() => 'CourseDiffuclty(diffuclty: $diffuclty, precentage: $precentage, color: $color)';

  @override
  bool operator ==(covariant CourseDiffuclty other) {
    if (identical(this, other)) return true;
  
    return 
      other.diffuclty == diffuclty &&
      other.precentage == precentage &&
      other.color == color;
  }

  @override
  int get hashCode => diffuclty.hashCode ^ precentage.hashCode ^ color.hashCode;
}
