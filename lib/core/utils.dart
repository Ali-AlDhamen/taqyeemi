import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:taqyeemi/models/course_comment_model.dart';

import '../features/course/screens/widgets/grade_container.dart';
import '../models/course_diffuclty_model.dart';
import '../models/course_model.dart';


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
  }
  else if (num <= 1){
    return const Text(
      'Unknown',
      style: TextStyle(color: Colors.grey, fontSize: 10),
    );
  }
   else {
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
      style: TextStyle(color: Colors.green, fontSize: 10),
    );
  } else if (num >= 80) {
    return const Text(
      'Average Grade (B)',
      style: TextStyle(color: Colors.green, fontSize: 10),
    );
  } else if (num >= 70) {
    return const Text(
      'Average Grade (C)',
      style: TextStyle(color: Colors.yellow, fontSize: 10),
    );
  } else if (num >= 60) {
    return const Text(
      'Average Grade (D)',
      style: TextStyle(color: Colors.orange, fontSize: 10),
    );
  } else {
    return const Text(
      'Average Grade (F)',
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


List<CourseDiffuclty> diffucltyOverTotal(Course course) {
    if (course.comments.isEmpty) {
      return [
        CourseDiffuclty(
            diffuclty: "Super Easy", precentage: 0, color: Colors.green),
        CourseDiffuclty(diffuclty: "Easy", precentage: 0, color: Colors.green),
        CourseDiffuclty(
            diffuclty: "Medium", precentage: 0, color: Colors.yellow),
        CourseDiffuclty(diffuclty: "Hard", precentage: 0, color: Colors.red),
        CourseDiffuclty(
            diffuclty: "Super Hard", precentage: 0, color: Colors.red),
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
          color: Colors.green),
      CourseDiffuclty(
          diffuclty: "Easy",
          precentage: easy / course.comments.length,
          color: Colors.green),
      CourseDiffuclty(
          diffuclty: "Medium",
          precentage: medium / course.comments.length,
          color: Colors.yellow),
      CourseDiffuclty(
          diffuclty: "Hard",
          precentage: hard / course.comments.length,
          color: Colors.red),
      CourseDiffuclty(
          diffuclty: "Super Hard",
          precentage: superHard / course.comments.length,
          color: Colors.red),
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
    // return as A+
    return courseDiffucltyLetter(sum / course.comments.length);
  }



  GradeContainer getGradeColor(CourseComment comment) {
    if (comment.grade == "A+" || comment.grade == "A") {
      return GradeContainer(text: comment.grade, color: Colors.green);
    } else if (comment.grade == "B+" || comment.grade == "B") {
      return GradeContainer(text: comment.grade, color: Colors.yellow);
    } else if (comment.grade == "C+" || comment.grade == "C") {
      return GradeContainer(text: comment.grade, color: Colors.orange);
    } else if (comment.grade == "D+" || comment.grade == "D") {
      return GradeContainer(text: comment.grade, color: Colors.red);
    } else if (comment.grade == "F") {
      return GradeContainer(text: comment.grade, color: Colors.red);
    }
    return GradeContainer(text: comment.grade, color: Colors.red);
  }

  GradeContainer getDiffucltyColor (CourseComment comment) {
    if (comment.difficulty == "Super Easy") {
      return GradeContainer(text: comment.difficulty, color: Colors.green);
    } else if (comment.difficulty == "Easy") {
      return GradeContainer(text: comment.difficulty, color: Colors.green);
    } else if (comment.difficulty == "Medium") {
      return GradeContainer(text: comment.difficulty, color: Colors.yellow);
    } else if (comment.difficulty == "Hard") {
      return GradeContainer(text: comment.difficulty, color: Colors.orange);
    } else if (comment.difficulty == "Super Hard") {
      return GradeContainer(text: comment.difficulty, color: Colors.red);
    }
    return GradeContainer(text: comment.difficulty, color: Colors.red);
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


ValueNotifier<double> valueNotifier(Course course){
    if(course.comments.isEmpty){
      return ValueNotifier(0);
    }
    double sum = 0;
    for (var element in course.comments) {
      sum += calculateGrade(element.grade);
      
    }
    return ValueNotifier(sum/course.comments.length);

  }