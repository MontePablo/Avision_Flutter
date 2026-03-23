import 'package:flutter/cupertino.dart';
class StudentIdQuizIdRequest {
  String studentId;
  String quizId;

  StudentIdQuizIdRequest({
    required this.quizId,
    required this.studentId
  });

  factory StudentIdQuizIdRequest.fromJson(Map<String, dynamic> json) => StudentIdQuizIdRequest(
    studentId: json["student_id"],
    quizId: json["quiz_id"],

  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "quiz_id": quizId,
  };
}
