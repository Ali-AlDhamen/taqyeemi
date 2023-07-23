import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:taqyeemi/models/course_comment_model.dart';
import 'package:taqyeemi/models/instructor_model.dart';
import 'package:taqyeemi/theme/pallete.dart';

import '../features/course/screens/widgets/grade_container.dart';
import '../models/course_diffuclty_model.dart';
import '../models/course_model.dart';
import '../models/instructor_comment_model.dart';

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
  } else if (num <= 1) {
    return const Text(
      'Unknown',
      style: TextStyle(color: Colors.grey, fontSize: 10),
    );
  } else {
    return const Text(
      'Very Hard',
      style: TextStyle(color: Colors.red, fontSize: 10),
    );
  }
}

Text courseDiffucltyLetter(double num) {
  if (num >= 90) {
    return const Text(
      'Average Grade (A)',
      style: TextStyle(color: Pallete.green, fontSize: 14),
    );
  } else if (num >= 80) {
    return const Text(
      'Average Grade (B)',
      style: TextStyle(color: Pallete.green, fontSize: 14),
    );
  } else if (num >= 70) {
    return const Text(
      'Average Grade (C)',
      style: TextStyle(color: Pallete.yellow, fontSize: 14),
    );
  } else if (num >= 60) {
    return const Text(
      'Average Grade (D)',
      style: TextStyle(color: Pallete.orange, fontSize: 14),
    );
  } else {
    return const Text(
      'Average Grade (F)',
      style: TextStyle(color: Pallete.red, fontSize: 14),
    );
  }
}

Color gradeColor(double num) {
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

List<CourseDiffuclty> diffucltyOverTotal(Course course) {
  if (course.comments.isEmpty) {
    return [
      CourseDiffuclty(
          diffuclty: "Super Easy", precentage: 0, color: Pallete.green),
      CourseDiffuclty(diffuclty: "Easy", precentage: 0, color: Pallete.green),
      CourseDiffuclty(
          diffuclty: "Medium", precentage: 0, color: Pallete.yellow),
      CourseDiffuclty(diffuclty: "Hard", precentage: 0, color: Pallete.red),
      CourseDiffuclty(
          diffuclty: "Super Hard", precentage: 0, color: Pallete.red),
    ];
  }
  double superEasy = 0;
  double easy = 0;
  double medium = 0;
  double hard = 0;
  double superHard = 0;
  for (var element in course.comments) {
    if (element.difficulty == "Super Easy") {
      superEasy++;
    } else if (element.difficulty == "Easy") {
      easy++;
    } else if (element.difficulty == "Medium") {
      medium++;
    } else if (element.difficulty == "Hard") {
      hard++;
    } else if (element.difficulty == "Super Hard") {
      superHard++;
    }
  }

  return [
    CourseDiffuclty(
        diffuclty: "Super Easy",
        precentage: superEasy / course.comments.length,
        color: Pallete.green),
    CourseDiffuclty(
        diffuclty: "Easy",
        precentage: easy / course.comments.length,
        color: Pallete.green),
    CourseDiffuclty(
        diffuclty: "Medium",
        precentage: medium / course.comments.length,
        color: Pallete.yellow),
    CourseDiffuclty(
        diffuclty: "Hard",
        precentage: hard / course.comments.length,
        color: Pallete.red),
    CourseDiffuclty(
        diffuclty: "Super Hard",
        precentage: superHard / course.comments.length,
        color: Pallete.red),
  ];
}

Text averageGrade(Course course) {
  if (course.comments.isEmpty) {
    return const Text("Average Grade (Unknown)");
  }
  double sum = 0;
  for (var element in course.comments) {
    sum += calculateGrade(element.grade);
  }
  return courseDiffucltyLetter(sum / course.comments.length);
}

GradeContainer getGradeColor(CourseComment comment) {
  if (comment.grade == "A+" || comment.grade == "A") {
    Text text = Text(
      comment.grade,
      style: const TextStyle(
          color: Pallete.green, fontSize: 12, fontWeight: FontWeight.bold),
    );
    return GradeContainer(text: text, color: Pallete.darkGreen);
  } else if (comment.grade == "B+" || comment.grade == "B") {
    Text text = Text(
      comment.grade,
      style: const TextStyle(
          color: Pallete.yellow, fontSize: 12, fontWeight: FontWeight.bold),
    );
    return GradeContainer(text: text, color: Pallete.darkYellow);
  } else if (comment.grade == "C+" || comment.grade == "C") {
    Text text = Text(
      comment.grade,
      style: const TextStyle(
          color: Pallete.orange, fontSize: 12, fontWeight: FontWeight.bold),
    );
    return GradeContainer(text: text, color: Pallete.darkOrange);
  } else {
    Text text = Text(
      comment.grade,
      style: const TextStyle(
          color: Pallete.red, fontSize: 12, fontWeight: FontWeight.bold),
    );
    return GradeContainer(text: text, color: Pallete.darkRed);
  }
}

GradeContainer getDiffucltyColor(CourseComment comment) {
  if (comment.difficulty == "Super Easy") {
    Text text = Text(
      comment.difficulty,
      style: const TextStyle(
          color: Pallete.green, fontSize: 12, fontWeight: FontWeight.bold),
    );

    return GradeContainer(text: text, color: Pallete.darkGreen);
  } else if (comment.difficulty == "Easy") {
    Text text = Text(
      comment.difficulty,
      style: const TextStyle(
          color: Pallete.green, fontSize: 12, fontWeight: FontWeight.bold),
    );
    return GradeContainer(text: text, color: Pallete.darkGreen);
  } else if (comment.difficulty == "Medium") {
    Text text = Text(
      comment.difficulty,
      style: const TextStyle(
          color: Pallete.yellow, fontSize: 12, fontWeight: FontWeight.bold),
    );
    return GradeContainer(text: text, color: Pallete.darkYellow);
  } else if (comment.difficulty == "Hard") {
    Text text = Text(
      comment.difficulty,
      style: const TextStyle(
          color: Pallete.orange, fontSize: 12, fontWeight: FontWeight.bold),
    );
    return GradeContainer(text: text, color: Pallete.darkOrange);
  } else if (comment.difficulty == "Super Hard") {
    Text text = Text(
      comment.difficulty,
      style: const TextStyle(
          color: Pallete.red, fontSize: 10, fontWeight: FontWeight.bold),
    );
    return GradeContainer(text: text, color: Pallete.darkRed);
  }
  Text text = Text(
    comment.difficulty,
    style: const TextStyle(
        color: Pallete.red, fontSize: 12, fontWeight: FontWeight.bold),
  );
  return GradeContainer(text: text, color: Pallete.darkRed);
}

String sinceWhen(DateTime date) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(date);
  if (difference.inDays > 0) {
    // more than 24 hours ago
    return '${difference.inDays} ${difference.inDays == 1 ? "day" : "days"} ago';
  } else if (difference.inHours > 0) {
    // more than an hour ago
    return '${difference.inHours} ${difference.inHours == 1 ? "hour" : "hours"} ago';
  } else if (difference.inMinutes > 0) {
    // more than a minute ago
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? "minute" : "minutes"} ago';
  } else {
    // less than a minute ago
    return 'just now';
  }
}

ValueNotifier<double> valueNotifier(Course course) {
  if (course.comments.isEmpty) {
    return ValueNotifier(0);
  }
  double sum = 0;
  for (var element in course.comments) {
    sum += calculateGrade(element.grade);
  }
  return ValueNotifier(sum / course.comments.length);
}

double calculateInstructor(Instructor instructor) {
  if (instructor.comments.isEmpty) {
    return 0;
  }
  double sum = 0;
  for (var element in instructor.comments) {
    sum += element.grading +
        element.attendance +
        element.teaching +
        element.treating;
  }
  // round to 2 decimal places
  return (sum / instructor.comments.length / 4).roundToDouble();
}

Color backGroundInstructorPrecentageColor(double num) {
  if (num >= 80) {
    return Pallete.darkGreen;
  } else if (num >= 70) {
    return Pallete.darkYellow;
  } else if (num >= 60) {
    return Pallete.darkOrange;
  } else {
    return Pallete.darkRed;
  }
}

Color textInstructorPrecentageColor(double num) {
  if (num >= 80) {
    return Pallete.green;
  } else if (num >= 70) {
    return Pallete.yellow;
  } else if (num >= 60) {
    return Pallete.orange;
  } else {
    return Pallete.red;
  }
}

int convertCourseDiffuclty(String diffuclty) {
  if (diffuclty == "Super Easy") {
    return 5;
  } else if (diffuclty == "Easy") {
    return 4;
  } else if (diffuclty == "Medium") {
    return 3;
  } else if (diffuclty == "Hard") {
    return 2;
  } else if (diffuclty == "Super Hard") {
    return 1;
  } else {
    return 0;
  }
}

List<double> getInstructorStats(List<InstructorComment> comments) {
  if (comments.isEmpty) {
    return [0, 0, 0, 0];
  }
  double sumGrading = 0;
  double sumAttendance = 0;
  double sumTeaching = 0;
  double sumTreating = 0;
  for (var element in comments) {
    sumGrading += element.grading;
    sumAttendance += element.attendance;
    sumTeaching += element.teaching;
    sumTreating += element.treating;
  }
  return [
    sumGrading / comments.length,
    sumAttendance / comments.length,
    sumTeaching / comments.length,
    sumTreating / comments.length
  ];
}

double getCourseAverageInNumber(List<CourseComment> comments) {
  if (comments.isEmpty) {
    return 0;
  }
  double sum = 0;
  for (var element in comments) {
    sum += calculateGrade(element.grade);
  }
  return sum / comments.length;
}

double getCourseDiffucltyInNumber(List<CourseComment> comments){
  if (comments.isEmpty) {
    return 0;
  }
  double sum = 0;
  for (var element in comments) {
    sum += convertCourseDiffuclty(element.difficulty);
  }
  return sum / comments.length;
}


String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (!value.contains('@') || !value.contains('.')) {
    return 'Please enter a valid email';
  }
  return null;
}