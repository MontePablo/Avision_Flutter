import 'package:flutter/cupertino.dart';
class SubjectwiseAllVideosVideoAppBarRequest {
  String studentId;
  String subjectId;
  SubjectwiseAllVideosVideoAppBarRequest({
    required this.studentId,
    required this.subjectId
  });

  factory SubjectwiseAllVideosVideoAppBarRequest.fromJson(Map<String, dynamic> json) => SubjectwiseAllVideosVideoAppBarRequest(
    studentId: json["student_id"],
    subjectId: json["subject_id"]
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "subject_id": subjectId
  };
}
