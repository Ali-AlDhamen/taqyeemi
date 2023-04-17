// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InstructorComment {
  final String id;
  final String instructorId;
  final String userId;
  final String courseCode;
  final String courseGrade;
  final String? comment;
  final DateTime date;
  final int teaching;
  final int grading;
  final int treating;
  final int attendance;
  InstructorComment({
    required this.id,
    required this.instructorId,
    required this.userId,
    required this.courseCode,
    required this.courseGrade,
    this.comment,
    required this.date,
    required this.teaching,
    required this.grading,
    required this.treating,
    required this.attendance,
  });

  InstructorComment copyWith({
    String? id,
    String? instructorId,
    String? userId,
    String? courseCode,
    String? courseGrade,
    String? comment,
    DateTime? date,
    int? teaching,
    int? grading,
    int? treating,
    int? attendance,
  }) {
    return InstructorComment(
      id: id ?? this.id,
      instructorId: instructorId ?? this.instructorId,
      userId: userId ?? this.userId,
      courseCode: courseCode ?? this.courseCode,
      courseGrade: courseGrade ?? this.courseGrade,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      teaching: teaching ?? this.teaching,
      grading: grading ?? this.grading,
      treating: treating ?? this.treating,
      attendance: attendance ?? this.attendance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'instructorId': instructorId,
      'userId': userId,
      'courseCode': courseCode,
      'courseGrade': courseGrade,
      'comment': comment,
      'date': date.millisecondsSinceEpoch,
      'teaching': teaching,
      'grading': grading,
      'treating': treating,
      'attendance': attendance,
    };
  }

  factory InstructorComment.fromMap(Map<String, dynamic> map) {
    return InstructorComment(
      id: map['id'] as String,
      instructorId: map['instructorId'] as String,
      userId: map['userId'] as String,
      courseCode: map['courseCode'] as String,
      courseGrade: map['courseGrade'] as String,
      comment: map['comment'] != null ? map['comment'] as String : null,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      teaching: map['teaching'] as int,
      grading: map['grading'] as int,
      treating: map['treating'] as int,
      attendance: map['attendance'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory InstructorComment.fromJson(String source) =>
      InstructorComment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InstructorComment(id: $id, instructorId: $instructorId, userId: $userId, courseCode: $courseCode, courseGrade: $courseGrade, comment: $comment, date: $date, teaching: $teaching, grading: $grading, treating: $treating, attendance: $attendance)';
  }

  @override
  bool operator ==(covariant InstructorComment other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.instructorId == instructorId &&
        other.userId == userId &&
        other.courseCode == courseCode &&
        other.courseGrade == courseGrade &&
        other.comment == comment &&
        other.date == date &&
        other.teaching == teaching &&
        other.grading == grading &&
        other.treating == treating &&
        other.attendance == attendance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        instructorId.hashCode ^
        userId.hashCode ^
        courseCode.hashCode ^
        courseGrade.hashCode ^
        comment.hashCode ^
        date.hashCode ^
        teaching.hashCode ^
        grading.hashCode ^
        treating.hashCode ^
        attendance.hashCode;
  }
}
