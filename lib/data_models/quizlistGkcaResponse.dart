class QuizlistGkcaResponse {
  String? statusCode;
  String? message;
  List<GkcaQuiz>? scheduleList;
  int? studentStatus;

  QuizlistGkcaResponse({
    this.statusCode,
    this.message,
    this.scheduleList,
    this.studentStatus,
  });

  factory QuizlistGkcaResponse.fromJson(Map<String, dynamic> json) => QuizlistGkcaResponse(
    statusCode: json["status_code"],
    message: json["message"],
    scheduleList: json["schedule_list"] == null ? [] : List<GkcaQuiz>.from(json["schedule_list"]!.map((x) => GkcaQuiz.fromJson(x))),
    studentStatus: json["student_status"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "schedule_list": scheduleList == null ? [] : List<dynamic>.from(scheduleList!.map((x) => x.toJson())),
    "student_status": studentStatus,
  };
}

class GkcaQuiz {
  String? courseName;
  String? quizId;
  String? quizName;
  String? totQus;
  String? totTime;

  GkcaQuiz({
    this.courseName,
    this.quizId,
    this.quizName,
    this.totQus,
    this.totTime,
  });

  factory GkcaQuiz.fromJson(Map<String, dynamic> json) => GkcaQuiz(
    courseName: json["course_name"],
    quizId: json["quiz_id"],
    quizName: json["quiz_name"],
    totQus: json["tot_qus"],
    totTime: json["tot_time"],
  );

  Map<String, dynamic> toJson() => {
    "course_name": courseName,
    "quiz_id": quizId,
    "quiz_name": quizName,
    "tot_qus": totQus,
    "tot_time": totTime,
  };
}
