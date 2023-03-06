import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Error',
      message: message,
      contentType: ContentType.failure,
    ),
  );

  // hide then show
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

int calculateGrade(String grade) {
  if (grade == 'A+') {
    return 100;
  } else if (grade == 'A') {
    return 95;
  } else if (grade == 'B+') {
    return 90;
  } else if (grade == 'B') {
    return 85;
  } else if (grade == 'C+') {
    return 80;
  } else if (grade == 'C') {
    return 75;
  } else if (grade == 'D+') {
    return 70;
  } else if (grade == 'D') {
    return 65;
  } else if (grade == 'F') {
    return 60;
  } else {
    return 0;
  }
}

Text courseDiffuclty(double num) {
  if (num >= 90) {
    return const Text(
      'Very Easy',
      style: TextStyle(color: Colors.green, fontSize: 10),
    );
  } else if (num >= 80) {
    return const Text(
      'Easy',
      style: TextStyle(color: Colors.green, fontSize: 10),
    );
  } else if (num >= 70) {
    return const Text(
      'Medium',
      style: TextStyle(color: Colors.yellow, fontSize: 10),
    );
  } else if (num >= 60) {
    return const Text(
      'Hard',
      style: TextStyle(color: Colors.orange, fontSize: 10),
    );
  } else {
    return const Text(
      'Very Hard',
      style: TextStyle(color: Colors.red, fontSize: 10),
    );
  }
}


MaterialColor gradeColor(double num) {
  if (num >= 90) {
    return Colors.green;
  } else if (num >= 80) {
    return Colors.green;
  } else if (num >= 70) {
    return Colors.yellow;
  } else if (num >= 60) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}