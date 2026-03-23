import 'package:flutter/cupertino.dart';
class PrevyearpaperSubjectsRequest {
  String studentId;
  String courseId;

  PrevyearpaperSubjectsRequest({
    required this.studentId,
    required this.courseId
  });

  factory PrevyearpaperSubjectsRequest.fromJson(Map<String, dynamic> json) => PrevyearpaperSubjectsRequest(
    studentId: json["student_id"],
    courseId: json["course_id"],
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "course_id": courseId,
  };
}
