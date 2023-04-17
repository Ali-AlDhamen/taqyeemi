import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taqyeemi/models/course_comment_model.dart';
import 'package:taqyeemi/theme/pallete.dart';

import '../../../../core/core.dart';


class CommentCard extends StatelessWidget {
  final CourseComment comment;

  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.all(10),
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
                    getGradeColor(comment),
                    const SizedBox(
                      width: 10,
                    ),
                    getDiffucltyColor(comment),
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
