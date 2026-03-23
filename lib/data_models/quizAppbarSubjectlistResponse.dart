class QuizAppbarSubjectlistResponse {
  String? statusCode;
  String? message;
  List<Subject>? scheduleList;
  dynamic studentStatus; // Could be a different type, depending on how student_status is structured

  QuizAppbarSubjectlistResponse({
    this.statusCode,
    this.message,
    this.scheduleList,
    this.studentStatus,
  });

  factory QuizAppbarSubjectlistResponse.fromJson(Map<String, dynamic> json) => QuizAppbarSubjectlistResponse(
    statusCode: json["status_code"],
    message: json["message"],
    scheduleList: json["schedule_list"] == null
        ? []
        : List<Subject>.from(json["schedule_list"].map((x) => Subject.fromJson(x))),
    studentStatus: json["student_status"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "schedule_list": scheduleList == null
        ? []
        : List<dynamic>.from(scheduleList!.map((x) => x.toJson())),
    "student_status": studentStatus,
  };
}

class Subject {
  String? typeId;
  int? childTypeId;
  String? name;
  int? noQuiz;
  int? status;

  Subject({
    this.typeId,
    this.childTypeId,
    this.name,
    this.noQuiz,
    this.status,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    typeId: json["type_id"],
    childTypeId: json["child_type_id"],
    name: json["name"],
    noQuiz: json["no_quiz"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "type_id": typeId,
    "child_type_id": childTypeId,
    "name": name,
    "no_quiz": noQuiz,
    "status": status,
  };
}
