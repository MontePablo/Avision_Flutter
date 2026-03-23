import 'dart:convert';

ExamListExaminfoExamstudypracticeResponse examListExamstudypracticeResponseFromJson(String str) => ExamListExaminfoExamstudypracticeResponse.fromJson(json.decode(str));

String examListExamstudypracticeResponseToJson(ExamListExaminfoExamstudypracticeResponse data) => json.encode(data.toJson());

class ExamListExaminfoExamstudypracticeResponse {
  int? status;
  String? msg;
  List<ExamCategory>? examCategory;

  ExamListExaminfoExamstudypracticeResponse({
    this.status,
    this.msg,
    this.examCategory,
  });

  factory ExamListExaminfoExamstudypracticeResponse.fromJson(Map<String, dynamic> json) => ExamListExaminfoExamstudypracticeResponse(
    status: json["status"],
    msg: json["msg"],
    examCategory: json["exam_category"] == null ? [] : List<ExamCategory>.from(json["exam_category"]!.map((x) => ExamCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "exam_category": examCategory == null ? [] : List<dynamic>.from(examCategory!.map((x) => x.toJson())),
  };
}

class ExamCategory {
  String? subCategoryId;
  String? subCategoryName;
  String? subCategoryImage;

  ExamCategory({
    this.subCategoryId,
    this.subCategoryName,
    this.subCategoryImage,
  });

  factory ExamCategory.fromJson(Map<String, dynamic> json) => ExamCategory(
    subCategoryId: json["sub_category_id"],
    subCategoryName: json["sub_category_name"],
    subCategoryImage: json["sub_category_image"],
  );

  Map<String, dynamic> toJson() => {
    "sub_category_id": subCategoryId,
    "sub_category_name": subCategoryName,
    "sub_category_image": subCategoryImage,
  };
}
