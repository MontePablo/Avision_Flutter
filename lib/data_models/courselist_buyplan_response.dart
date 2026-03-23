class CourselistBuyplanResponse {
  String? statusCode;
  String? message;
  List<CourseBuyplan>? notificationList;

  CourselistBuyplanResponse({
    this.statusCode,
    this.message,
    this.notificationList,
  });

  factory CourselistBuyplanResponse.fromJson(Map<String, dynamic> json) => CourselistBuyplanResponse(
    statusCode: json["status_code"],
    message: json["message"],
    notificationList: json["notification_list"] == null ? [] : List<CourseBuyplan>.from(json["notification_list"]!.map((x) => CourseBuyplan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "notification_list": notificationList == null ? [] : List<dynamic>.from(notificationList!.map((x) => x.toJson())),
  };
}

class CourseBuyplan {
  dynamic coursesId;
  String? coursesName;
  String? coursesIcon;
  int? testCount;

  CourseBuyplan({
    this.coursesId,
    this.coursesName,
    this.coursesIcon,
    this.testCount,
  });

  factory CourseBuyplan.fromJson(Map<String, dynamic> json) => CourseBuyplan(
    coursesId: json["courses_id"],
    coursesName: json["courses_name"],
    coursesIcon: json["courses_icon"],
    testCount: json["test_count"],
  );

  Map<String, dynamic> toJson() => {
    "courses_id": coursesId,
    "courses_name": coursesName,
    "courses_icon": coursesIcon,
    "test_count": testCount,
  };
}
