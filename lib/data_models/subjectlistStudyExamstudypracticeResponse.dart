class SubjectlistStudyExamstudypracticeResponse {
  String? statusCode;
  String? message;
  List<StudyExamstudypracticeSubject>? subjectList;

  SubjectlistStudyExamstudypracticeResponse({
    this.statusCode,
    this.message,
    this.subjectList,
  });

  factory SubjectlistStudyExamstudypracticeResponse.fromJson(Map<String, dynamic> json) => SubjectlistStudyExamstudypracticeResponse(
    statusCode: json["status_code"],
    message: json["message"],
    subjectList: json["subject_list"] == null ? [] : List<StudyExamstudypracticeSubject>.from(json["subject_list"]!.map((x) => StudyExamstudypracticeSubject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "subject_list": subjectList == null ? [] : List<dynamic>.from(subjectList!.map((x) => x.toJson())),
  };
}

class StudyExamstudypracticeSubject {
  String? typeId;
  String? typeName;
  String? typeImg;
  String? typeSlug;
  int? topicCount;
  int? totalConceptCount;
  int? totalVideoCount;

  StudyExamstudypracticeSubject({
    this.typeId,
    this.typeName,
    this.typeImg,
    this.typeSlug,
    this.topicCount,
    this.totalConceptCount,
    this.totalVideoCount,
  });

  factory StudyExamstudypracticeSubject.fromJson(Map<String, dynamic> json) => StudyExamstudypracticeSubject(
    typeId: json["type_id"],
    typeName: json["type_name"],
    typeImg: json["type_img"],
    typeSlug: json["type_slug"],
    topicCount: json["topic_count"],
    totalConceptCount: json["total_concept_count"],
    totalVideoCount: json["total_video_count"],
  );

  Map<String, dynamic> toJson() => {
    "type_id": typeId,
    "type_name": typeName,
    "type_img": typeImg,
    "type_slug": typeSlug,
    "topic_count": topicCount,
    "total_concept_count": totalConceptCount,
    "total_video_count": totalVideoCount,
  };
}
