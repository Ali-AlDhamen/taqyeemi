import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../core/core.dart';

import '../../../../models/instructor_comment_model.dart';
import '../../../../theme/pallete.dart';

class InstructorCommentWidget extends StatelessWidget {
  final InstructorComment comment;
  const InstructorCommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
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
                  Container(
                    width: 80,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(comment.courseCode),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 60,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(comment.courseGrade),
                    ),
                  ),
                ],
              ),
              Text(sinceWhen(comment.date)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 35,
                decoration:  BoxDecoration(
                  color: backGroundInstructorPrecentageColor(comment.attendance + 0.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Attendance ${comment.attendance}%",
                    style: TextStyle(color: textInstructorPrecentageColor(comment.attendance + 0.0), fontSize: 8),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 35,
                decoration:  BoxDecoration(
                  color: backGroundInstructorPrecentageColor(comment.treating + 0.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Attitude ${comment.treating}%",
                    style: TextStyle(
                      color: textInstructorPrecentageColor(comment.treating + 0.0),
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 35,
                decoration:  BoxDecoration(
                  color: backGroundInstructorPrecentageColor(comment.teaching + 0.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Teaching ${comment.teaching}%",
                    style: TextStyle(
                      color: textInstructorPrecentageColor(comment.teaching + 0.0),
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 35,
                decoration:  BoxDecoration(
                  color: backGroundInstructorPrecentageColor(comment.grading + 0.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Grading ${comment.grading}%",
                    style: TextStyle(
                      color: textInstructorPrecentageColor(comment.grading + 0.0),
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
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
      ),
    );
  }
}
