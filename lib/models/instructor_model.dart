import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'instructor_comment_model.dart';

class Instructor {
  final String id;
  final String name;
  final String college;
  final List<InstructorComment> comments;
  Instructor({
    required this.id,
    required this.name,
    required this.college,
    required this.comments,
  });

  Instructor copyWith({
    String? id,
    String? name,
    String? college,
    List<InstructorComment>? comments,
  }) {
    return Instructor(
      id: id ?? this.id,
      name: name ?? this.name,
      college: college ?? this.college,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'college': college,
      'comments': comments.map((x) => x.toMap()).toList(),
    };
  }

  factory Instructor.fromMap(Map<String, dynamic> map) {
    return Instructor(
      id: map['id'] as String,
      name: map['name'] as String,
      college: map['college'] as String,
      comments: List<InstructorComment>.from(
        (map['comments'] as List<dynamic>).map<InstructorComment>(
          (x) => InstructorComment.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Instructor.fromJson(String source) =>
      Instructor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Instructor(id: $id, name: $name, college: $college, comments: $comments)';
  }

  @override
  bool operator ==(covariant Instructor other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.college == college &&
        listEquals(other.comments, comments);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ college.hashCode ^ comments.hashCode;
  }
}
