// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'course_comment_model.dart';

class Course {
  final String id;
  final String code;
  final String name;
  final int creditHours;
  final List<CourseComment> comments;
  Course({
    required this.id,
    required this.code,
    required this.name,
    required this.creditHours,
    required this.comments,
  });

  Course copyWith({
    String? id,
    String? code,
    String? name,
    int? creditHours,
    List<CourseComment>? comments,
  }) {
    return Course(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      creditHours: creditHours ?? this.creditHours,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'name': name,
      'creditHours': creditHours,
      'comments': comments.map((x) => x.toMap()).toList(),
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'] as String,
      code: map['code'] as String,
      name: map['name'] as String,
      creditHours: map['creditHours'] as int,
      comments: List<CourseComment>.from((map['comments'] as List<dynamic>).map<CourseComment>((x) => CourseComment.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Course(id: $id, code: $code, name: $name, creditHours: $creditHours, comments: $comments)';
  }

  @override
  bool operator ==(covariant Course other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.code == code &&
      other.name == name &&
      other.creditHours == creditHours &&
      listEquals(other.comments, comments);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      code.hashCode ^
      name.hashCode ^
      creditHours.hashCode ^
      comments.hashCode;
  }
}

