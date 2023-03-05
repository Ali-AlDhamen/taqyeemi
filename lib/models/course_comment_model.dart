import 'dart:convert';

class CourseComment {
  final String id;
  final String? comment;
  final String difficulty;
  final String grade;
  final String userId;
  final String courseId;
  final DateTime date;
  CourseComment({
    required this.id,
    this.comment,
    required this.difficulty,
    required this.grade,
    required this.userId,
    required this.courseId,
    required this.date,
  });

  CourseComment copyWith({
    String? id,
    String? comment,
    String? difficulty,
    String? grade,
    String? userId,
    String? courseId,
    DateTime? date,
  }) {
    return CourseComment(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      difficulty: difficulty ?? this.difficulty,
      grade: grade ?? this.grade,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'comment': comment,
      'difficulty': difficulty,
      'grade': grade,
      'userId': userId,
      'courseId': courseId,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory CourseComment.fromMap(Map<String, dynamic> map) {
    return CourseComment(
      id: map['id'] as String,
      comment: map['comment'] != null ? map['comment'] as String : null,
      difficulty: map['difficulty'] as String,
      grade: map['grade'] as String,
      userId: map['userId'] as String,
      courseId: map['courseId'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseComment.fromJson(String source) => CourseComment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseComment(id: $id, comment: $comment, difficulty: $difficulty, grade: $grade, userId: $userId, courseId: $courseId, date: $date)';
  }

  @override
  bool operator ==(covariant CourseComment other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.comment == comment &&
      other.difficulty == difficulty &&
      other.grade == grade &&
      other.userId == userId &&
      other.courseId == courseId &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      comment.hashCode ^
      difficulty.hashCode ^
      grade.hashCode ^
      userId.hashCode ^
      courseId.hashCode ^
      date.hashCode;
  }
}
