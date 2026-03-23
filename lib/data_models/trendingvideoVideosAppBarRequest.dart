import 'package:flutter/cupertino.dart';
class TrendingVideoVideosAppBarRequest {
  String studentId;

  TrendingVideoVideosAppBarRequest({
    required this.studentId,
  });

  factory TrendingVideoVideosAppBarRequest.fromJson(Map<String, dynamic> json) => TrendingVideoVideosAppBarRequest(
    studentId: json["student_id"],
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}
