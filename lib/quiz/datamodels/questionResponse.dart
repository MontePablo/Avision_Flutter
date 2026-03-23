import 'package:hive/hive.dart';
part 'questionResponse.g.dart'; // Required for generated adapter code

class QuizQuestionResponse {
  int? statusCode;
  String? message;
  List<QuizDtl>? questionList;

  QuizQuestionResponse({
    this.statusCode,
    this.message,
    this.questionList,
  });

  factory QuizQuestionResponse.fromJson(Map<String, dynamic> json) => QuizQuestionResponse(
    statusCode: json["status_code"],
    message: json["message"],
    questionList: json["question_list"] == null ? [] : List<QuizDtl>.from(json["question_list"].map((x) => QuizDtl.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "question_list": questionList == null ? [] : List<dynamic>.from(questionList!.map((x) => x.toJson())),
  };
}


@HiveType(typeId: 0)
class QuizDtl extends HiveObject {
  @HiveField(0)
  dynamic testId;

  @HiveField(1)
  dynamic totalQus;

  @HiveField(2)
  int? correctMarks;

  @HiveField(3)
  double? negativeMarks;

  @HiveField(4)
  int? totalTime;

  @HiveField(5)
  List<QuestionDtl>? questionDtls;

  @HiveField(6)
  int? timeLeftInSec;

  @HiveField(7)
  String? quizSection;

  QuizDtl({
    this.testId,
    this.totalQus,
    this.correctMarks,
    this.negativeMarks,
    this.totalTime,
    this.questionDtls,
    this.timeLeftInSec,
    this.quizSection,
  });

  factory QuizDtl.fromJson(Map<String, dynamic> json) => QuizDtl(
    testId: json["test_id"],
    totalQus: json["total_qus"],
    correctMarks: json["correct_marks"],
    negativeMarks: json["negative_marks"],
    totalTime: json["total_time"],
    questionDtls: json["question_dtls"] == null ? [] : List<QuestionDtl>.from(json["question_dtls"].map((x) => QuestionDtl.fromJson(x))),
    timeLeftInSec: json["timeLeftInSec"],
    quizSection: json["quizSection"],
  );

  Map<String, dynamic> toJson() => {
    "test_id": testId,
    "total_qus": totalQus,
    "correct_marks": correctMarks,
    "negative_marks": negativeMarks,
    "total_time": totalTime,
    "question_dtls": questionDtls == null ? [] : List<dynamic>.from(questionDtls!.map((x) => x.toJson())),
    "timeLeftInSec": timeLeftInSec,
    "quizSection": quizSection,
  };
}

@HiveType(typeId: 1)
class QuestionDtl extends HiveObject {
  @HiveField(0)
  String? questionId;

  @HiveField(1)
  int? qno;

  @HiveField(2)
  String? question;

  @HiveField(3)
  List<Ans>? ans;

  @HiveField(4)
  bool? isReviewed;

  @HiveField(5)
  int? selectedAnsPos;

  @HiveField(6)
  String? givenAnsStat;

  QuestionDtl({
    this.questionId,
    this.qno,
    this.question,
    this.ans,
    this.isReviewed,
    this.selectedAnsPos,
    this.givenAnsStat,
  });

  factory QuestionDtl.fromJson(Map<String, dynamic> json) => QuestionDtl(
    questionId: json["question_id"],
    qno: json["Qno"],
    question: json["question"],
    ans: json["ans"] == null ? [] : List<Ans>.from(json["ans"].map((x) => Ans.fromJson(x))),
    isReviewed: json["isReviewed"],
    selectedAnsPos: json["selectedAnsPos"],
    givenAnsStat: json["given_ans_stat"],
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "Qno": qno,
    "question": question,
    "ans": ans == null ? [] : List<dynamic>.from(ans!.map((x) => x.toJson())),
    "isReviewed": isReviewed,
    "selectedAnsPos": selectedAnsPos,
    "given_ans_stat": givenAnsStat,
  };
}

@HiveType(typeId: 2)
class Ans extends HiveObject {
  @HiveField(0)
  String? answerId;

  @HiveField(1)
  String? answer;

  @HiveField(2)
  String? answerStatus;

  Ans({
    this.answerId,
    this.answer,
    this.answerStatus,
  });

  factory Ans.fromJson(Map<String, dynamic> json) => Ans(
    answerId: json["answer_id"],
    answer: json["answer"],
    answerStatus: json["answer_status"],
  );

  Map<String, dynamic> toJson() => {
    "answer_id": answerId,
    "answer": answer,
    "answer_status": answerStatus,
  };
}
