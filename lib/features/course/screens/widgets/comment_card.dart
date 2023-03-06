// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taqyeemi/features/course/screens/widgets/grade_container.dart';
import 'package:taqyeemi/models/course_comment_model.dart';
import 'package:taqyeemi/theme/pallete.dart';

class CommentCard extends StatelessWidget {
  CourseComment comment;

  CommentCard({super.key, required this.comment});

  GradeContainer getGradeColor() {
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

  GradeContainer getDiffucltyColor() {
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

  @override
  Widget build(BuildContext context) {
    // get width and height
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        width: width * 0.9,
        decoration: BoxDecoration(
          color: Pallete.grayColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    getGradeColor(),
                    const SizedBox(
                      width: 10,
                    ),
                    getDiffucltyColor(),
                  ],
                ),
                Text(sinceWhen(comment.date)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                comment.comment == "" || comment.comment == null
                    ? "No Comment"
                    : comment.comment!,
                style: const TextStyle(fontSize: 18),
                minFontSize: 12,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ));
  }
}
