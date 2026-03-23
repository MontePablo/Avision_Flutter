class QuizAppbarQuizlistResponse {
  String? statusCode;
  String? message;
  List<AppbarQuiz>? questionList;
  int? studentStatus;

  QuizAppbarQuizlistResponse({
    this.statusCode,
    this.message,
    this.questionList,
    this.studentStatus,
  });

  factory QuizAppbarQuizlistResponse.fromJson(Map<String, dynamic> json) => QuizAppbarQuizlistResponse(
    statusCode: json["status_code"],
    message: json["message"],
    questionList: json["question_list"] == null
        ? []
        : List<AppbarQuiz>.from(json["question_list"].map((x) => AppbarQuiz.fromJson(x))),
    studentStatus: json["student_status"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "question_list": questionList == null
        ? []
        : List<dynamic>.from(questionList!.map((x) => x.toJson())),
    "student_status": studentStatus,
  };
}

class AppbarQuiz {
  String? courseName;
  String? quizId;
  String? quizName;
  String? totQus;
  String? totTime;

  AppbarQuiz({
    this.courseName,
    this.quizId,
    this.quizName,
    this.totQus,
    this.totTime,
  });

  factory AppbarQuiz.fromJson(Map<String, dynamic> json) => AppbarQuiz(
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
