import 'package:avision/data_models/multiApiTwoHomeResponse.dart';

class DailyAssignmentQuizListResponse {
  String? statusCode;
  String? message;
  List<DailyAssignment>? dailyAssignment;

  DailyAssignmentQuizListResponse({
    this.statusCode,
    this.message,
    this.dailyAssignment,
  });

  factory DailyAssignmentQuizListResponse.fromJson(Map<String, dynamic> json) => DailyAssignmentQuizListResponse(
    statusCode: json["status_code"],
    message: json["message"],
    dailyAssignment: json["daily_assignment"] == null
        ? []
        : List<DailyAssignment>.from(json["daily_assignment"].map((x) => DailyAssignment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "daily_assignment": dailyAssignment == null
        ? []
        : List<dynamic>.from(dailyAssignment!.map((x) => x.toJson())),
  };
}

class DailyAssignment {
  List<DailyDoseQuiz>? quizList;

  DailyAssignment({
    this.quizList,
  });

  factory DailyAssignment.fromJson(Map<String, dynamic> json) => DailyAssignment(
    quizList: json["quiz_list"] == null
        ? []
        : List<DailyDoseQuiz>.from(json["quiz_list"].map((x) => DailyDoseQuiz.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "quiz_list": quizList == null
        ? []
        : List<dynamic>.from(quizList!.map((x) => x.toJson())),
  };
}
