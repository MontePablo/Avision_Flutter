import 'package:flutter/cupertino.dart';
class AssignmentChapterStudentzoneRequest {
  String subjectId;

  AssignmentChapterStudentzoneRequest({
    required this.subjectId,
  });

  factory AssignmentChapterStudentzoneRequest.fromJson(Map<String, dynamic> json) => AssignmentChapterStudentzoneRequest(
    subjectId: json["subject_id"],
  );

  Map<String, dynamic> toJson() => {
    "subject_id": subjectId,
  };
}
