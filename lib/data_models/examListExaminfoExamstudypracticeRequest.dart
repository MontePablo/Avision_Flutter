class ExamlistExaminfoExamstudypracticeRequest {
  String? courseId;

  ExamlistExaminfoExamstudypracticeRequest({
    this.courseId,
  });

  factory ExamlistExaminfoExamstudypracticeRequest.fromJson(Map<String, dynamic> json) => ExamlistExaminfoExamstudypracticeRequest(
    courseId: json["course_id"],
  );

  Map<String, dynamic> toJson() => {
    "course_id": courseId,
  };
}
