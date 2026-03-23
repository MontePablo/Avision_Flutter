class QuizResultResponse {
  String? statusCode;
  Result? message;

  QuizResultResponse({
    this.statusCode,
    this.message,
  });

  factory QuizResultResponse.fromJson(Map<String, dynamic> json) => QuizResultResponse(
    statusCode: json["status_code"],
    message: json["message"] == null ? null : Result.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message?.toJson(),
  };
}

class Result {
  int? totalTime;
  int? totalMarks;
  int? skip;
  int? wrongAnswer;
  int? correctAnswer;
  String? totalCalculatedTime;
  String? finalMsg;

  Result({
    this.totalTime,
    this.totalMarks,
    this.skip,
    this.wrongAnswer,
    this.correctAnswer,
    this.totalCalculatedTime,
    this.finalMsg,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    totalTime: json["total_time"],
    totalMarks: json["total_marks"],
    skip: json["skip"],
    wrongAnswer: json["wrong_answer"],
    correctAnswer: json["corrent_answer"],
    totalCalculatedTime: json["total_calculated_time"],
    finalMsg: json["final_msg"],
  );

  Map<String, dynamic> toJson() => {
    "total_time": totalTime,
    "total_marks": totalMarks,
    "skip": skip,
    "wrong_answer": wrongAnswer,
    "corrent_answer": correctAnswer,
    "total_calculated_time": totalCalculatedTime,
    "final_msg": finalMsg,
  };
}
