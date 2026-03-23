

import 'package:avision/quiz/datamodels/questionResponse.dart';

class QuizResultWithGivenAnsResponse {
  int? statusCode;
  String? message;
  List<QuestionDtl>? questionList;

  QuizResultWithGivenAnsResponse({
    this.statusCode,
    this.message,
    this.questionList,
  });

  factory QuizResultWithGivenAnsResponse.fromJson(Map<String, dynamic> json) => QuizResultWithGivenAnsResponse(
    statusCode: json["status_code"],
    message: json["message"],
    questionList: json["question_list"] == null ? [] : List<QuestionDtl>.from(json["question_list"].map((x) => QuestionDtl.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "question_list": questionList == null ? [] : List<dynamic>.from(questionList!.map((x) => x.toJson())),
  };
}
