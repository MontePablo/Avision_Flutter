class ExamListTestSeriesRequest {
  String? courseId;

  ExamListTestSeriesRequest({
    this.courseId,
  });

  factory ExamListTestSeriesRequest.fromJson(Map<String, dynamic> json) => ExamListTestSeriesRequest(
    courseId: json["course_id"],
  );

  Map<String, dynamic> toJson() => {
    "course_id": courseId,
  };
}
