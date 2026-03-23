import 'package:flutter/cupertino.dart';
class PrevyearpaperTestsRequest {
  String studentId;
  String subCatId;
  String sectionId;
  PrevyearpaperTestsRequest({
    required this.studentId,
    required this.sectionId,
    required this.subCatId
  });

  factory PrevyearpaperTestsRequest.fromJson(Map<String, dynamic> json) => PrevyearpaperTestsRequest(
    studentId: json["student_id"],
    subCatId: json["sub_cat_id"],
    sectionId: json["section_id"]
  );

  Map<String, dynamic> toJson() => {
    "subject_id": studentId,
    "section_id": sectionId,
    "sub_cat_id": subCatId

  };
}
