class QuizAnsSubmitRequest {
  dynamic quizId;
  String? userId;
  int? attempt;
  int? notAttempt;
  int? review;
  int? correct;
  int? incorrect;
  double? marksObtained;
  List<QuestionAnswerList>? questionAnswerList;
  int? timeTaken;

  QuizAnsSubmitRequest({
    this.quizId,
    this.userId,
    this.attempt,
    this.notAttempt,
    this.review,
    this.correct,
    this.incorrect,
    this.marksObtained,
    this.questionAnswerList,
    this.timeTaken,
  });

  factory QuizAnsSubmitRequest.fromJson(Map<String, dynamic> json) => QuizAnsSubmitRequest(
    quizId: json["quiz_id"],
    userId: json["user_id"],
    attempt: json["attempt"],
    notAttempt: json["not_attempt"],
    review: json["review"],
    correct: json["correct"],
    incorrect: json["incorrect"],
    marksObtained: json["marks_obtained"],
    questionAnswerList: json["question_answer_list"] == null ? [] : List<QuestionAnswerList>.from(json["question_answer_list"].map((x) => QuestionAnswerList.fromJson(x))),
    timeTaken: json["time_taken"],
  );

  Map<String, dynamic> toJson() => {
    "quiz_id": quizId,
    "user_id": userId,
    "attempt": attempt,
    "not_attempt": notAttempt,
    "review": review,
    "correct": correct,
    "incorrect": incorrect,
    "marks_obtained": marksObtained,
    "question_answer_list": questionAnswerList == null ? [] : List<dynamic>.from(questionAnswerList!.map((x) => x.toJson())),
    "time_taken": timeTaken,
  };
}

class QuestionAnswerList {
  String? questionId;
  String? answerId;

  QuestionAnswerList({
    this.questionId,
    this.answerId,
  });

  factory QuestionAnswerList.fromJson(Map<String, dynamic> json) => QuestionAnswerList(
    questionId: json["question_id"],
    answerId: json["answer_id"],
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "answer_id": answerId,
  };
}
