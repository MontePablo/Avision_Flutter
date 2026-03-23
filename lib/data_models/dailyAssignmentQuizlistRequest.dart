import 'package:flutter/cupertino.dart';
class DailyassignmentQuizlistRequest {
  String date;
  String studentId;

  DailyassignmentQuizlistRequest({
    required this.date,
    required this.studentId,
  });

  factory DailyassignmentQuizlistRequest.fromJson(Map<String, dynamic> json) => DailyassignmentQuizlistRequest(
    studentId: json["student_id"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "date": date,
  };
}
