import 'package:flutter/cupertino.dart';
class SubjectWiseVideoVideosAppBarRequest {
  String studentId;

  SubjectWiseVideoVideosAppBarRequest({
    required this.studentId,
  });

  factory SubjectWiseVideoVideosAppBarRequest.fromJson(Map<String, dynamic> json) => SubjectWiseVideoVideosAppBarRequest(
    studentId: json["student_id"],
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}
