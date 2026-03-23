import 'package:flutter/cupertino.dart';
class QuizAppbarQuizlistRequest {
  String childTypeId;
  String typeId;
  String studentId;

  QuizAppbarQuizlistRequest({
    required this.studentId,
    required this.childTypeId,
    required this.typeId
  });

  factory QuizAppbarQuizlistRequest.fromJson(Map<String, dynamic> json) => QuizAppbarQuizlistRequest(
    studentId: json["student_id"],
    typeId: json["type_id"],
    childTypeId: json["child_type_id"],

  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "child_type_id": childTypeId,
    "type_id": typeId
  };
}
