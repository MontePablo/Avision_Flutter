class SubjectsPracticeExamstudypracticeResponse {
  String? statusCode;
  String? message;
  Result? result;

  SubjectsPracticeExamstudypracticeResponse({
    this.statusCode,
    this.message,
    this.result,
  });

  factory SubjectsPracticeExamstudypracticeResponse.fromJson(Map<String, dynamic> json) => SubjectsPracticeExamstudypracticeResponse(
    statusCode: json["status_code"],
    message: json["message"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
  List<SubjectPractice>? subjectCount;
  QuestionAnalysis? questionAnalysis;
  List<TopicOfTheDay>? topicOfTheDay;

  Result({
    this.subjectCount,
    this.questionAnalysis,
    this.topicOfTheDay,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    subjectCount: json["Subject_count"] == null ? [] : List<SubjectPractice>.from(json["Subject_count"]!.map((x) => SubjectPractice.fromJson(x))),
    questionAnalysis: json["question_analysis"] == null ? null : QuestionAnalysis.fromJson(json["question_analysis"]),
    topicOfTheDay: json["topic_of_the_day"] == null ? [] : List<TopicOfTheDay>.from(json["topic_of_the_day"]!.map((x) => TopicOfTheDay.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Subject_count": subjectCount == null ? [] : List<dynamic>.from(subjectCount!.map((x) => x.toJson())),
    "question_analysis": questionAnalysis?.toJson(),
    "topic_of_the_day": topicOfTheDay == null ? [] : List<dynamic>.from(topicOfTheDay!.map((x) => x.toJson())),
  };
}

class QuestionAnalysis {
  String? totalQuestionAttempted;
  String? totalQuestion;
  int? accuracy;

  QuestionAnalysis({
    this.totalQuestionAttempted,
    this.totalQuestion,
    this.accuracy,
  });

  factory QuestionAnalysis.fromJson(Map<String, dynamic> json) => QuestionAnalysis(
    totalQuestionAttempted: json["total_question_attempted"],
    totalQuestion: json["total_question"],
    accuracy: json["accuracy"],
  );

  Map<String, dynamic> toJson() => {
    "total_question_attempted": totalQuestionAttempted,
    "total_question": totalQuestion,
    "accuracy": accuracy,
  };
}

class SubjectPractice {
  String? subjectId;
  String? subjectName;
  int? count;
  int? givenQnCount;

  SubjectPractice({
    this.subjectId,
    this.subjectName,
    this.count,
    this.givenQnCount,
  });

  factory SubjectPractice.fromJson(Map<String, dynamic> json) => SubjectPractice(
    subjectId: json["subject_id"],
    subjectName: json["subject_name"],
    count: json["count"],
    givenQnCount: json["given_qn_count"],
  );

  Map<String, dynamic> toJson() => {
    "subject_id": subjectId,
    "subject_name": subjectName,
    "count": count,
    "given_qn_count": givenQnCount,
  };
}

class TopicOfTheDay {
  String? chapterId;
  String? chapterName;
  String? parentSubjectId;

  TopicOfTheDay({
    this.chapterId,
    this.chapterName,
    this.parentSubjectId,
  });

  factory TopicOfTheDay.fromJson(Map<String, dynamic> json) => TopicOfTheDay(
    chapterId: json["chapter_id"],
    chapterName: json["chapter_name"],
    parentSubjectId: json["parent_subject_id"],
  );

  Map<String, dynamic> toJson() => {
    "chapter_id": chapterId,
    "chapter_name": chapterName,
    "parent_subject_id": parentSubjectId,
  };
}
