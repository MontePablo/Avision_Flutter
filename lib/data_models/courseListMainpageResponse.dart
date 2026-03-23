class CourseListMainpageResponse {
  int? status;
  String? msg;
  List<Course>? courseList;

  CourseListMainpageResponse({
    this.status,
    this.msg,
    this.courseList,
  });

  factory CourseListMainpageResponse.fromJson(Map<String, dynamic> json) => CourseListMainpageResponse(
    status: json["status"],
    msg: json["msg"],
    courseList: json["course_list"] == null ? [] : List<Course>.from(json["course_list"]!.map((x) => Course.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "course_list": courseList == null ? [] : List<dynamic>.from(courseList!.map((x) => x.toJson())),
  };
}

class Course {
  String? coursesId;
  String? coursesName;
  String? coursesIcon;
  dynamic priority;
  String? examList;

  Course({
    this.coursesId,
    this.coursesName,
    this.coursesIcon,
    this.priority,
    this.examList,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    coursesId: json["courses_id"],
    coursesName: json["courses_name"],
    coursesIcon: json["courses_icon"],
    priority: json["priority"],
    examList: json["examList"],
  );

  Map<String, dynamic> toJson() => {
    "courses_id": coursesId,
    "courses_name": coursesName,
    "courses_icon": coursesIcon,
    "priority": priority,
    "examList": examList,
  };
}
