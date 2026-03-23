import 'package:flutter/cupertino.dart';
class StudentIdRequest {
  String studentId;

  StudentIdRequest({
    required this.studentId
  });

  factory StudentIdRequest.fromJson(Map<String, dynamic> json) => StudentIdRequest(
    studentId: json["student_id"],
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}
