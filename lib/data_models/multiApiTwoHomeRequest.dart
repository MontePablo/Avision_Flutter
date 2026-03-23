import 'package:flutter/cupertino.dart';
class MultiApiTwoHomeRequest {
  String studentId;

  MultiApiTwoHomeRequest({
    required this.studentId,
  });

  factory MultiApiTwoHomeRequest.fromJson(Map<String, dynamic> json) => MultiApiTwoHomeRequest(
    studentId: json["student_id"],
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}
