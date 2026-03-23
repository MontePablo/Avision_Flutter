class PrevyearpaperTestsResponse {
  String? statusCode;
  String? message;
  List<PrevYrTest>? previousYearQuizList;

  PrevyearpaperTestsResponse({
    this.statusCode,
    this.message,
    this.previousYearQuizList,
  });

  factory PrevyearpaperTestsResponse.fromJson(Map<String, dynamic> json) => PrevyearpaperTestsResponse(
    statusCode: json["status_code"],
    message: json["message"],
    previousYearQuizList: json["previous_year_quiz_list"] == null ? [] : List<PrevYrTest>.from(json["previous_year_quiz_list"]!.map((x) => PrevYrTest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "previous_year_quiz_list": previousYearQuizList == null ? [] : List<dynamic>.from(previousYearQuizList!.map((x) => x.toJson())),
  };
}

class PrevYrTest {
  String? quizName;
  String? quizId;
  String? noOfQs;
  String? changable;
  String? duration;
  String? correctMark;
  String? negativeMark;
  int? examStatus;

  PrevYrTest({
    this.quizName,
    this.quizId,
    this.noOfQs,
    this.changable,
    this.duration,
    this.correctMark,
    this.negativeMark,
    this.examStatus,
  });

  factory PrevYrTest.fromJson(Map<String, dynamic> json) => PrevYrTest(
    quizName: json["quiz_name"],
    quizId: json["quiz_id"],
    noOfQs: json["no_of_qs"],
    changable: json["changable"],
    duration: json["duration"],
    correctMark: json["correct_mark"],
    negativeMark: json["negative_mark"],
    examStatus: json["exam_status"],
  );

  Map<String, dynamic> toJson() => {
    "quiz_name": quizName,
    "quiz_id": quizId,
    "no_of_qs": noOfQs,
    "changable": changable,
    "duration": duration,
    "correct_mark": correctMark,
    "negative_mark": negativeMark,
    "exam_status": examStatus,
  };
}
