import 'package:flutter/cupertino.dart';
class CourseListHomepageRequest {
  String userId;

  CourseListHomepageRequest({
    required this.userId,
  });

  factory CourseListHomepageRequest.fromJson(Map<String, dynamic> json) => CourseListHomepageRequest(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
