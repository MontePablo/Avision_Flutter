class PrevyearpaperSubjectsResponse {
  String? statusCode;
  String? message;
  List<PrevYrSubject>? previousYearTestList;

  PrevyearpaperSubjectsResponse({
    this.statusCode,
    this.message,
    this.previousYearTestList,
  });

  factory PrevyearpaperSubjectsResponse.fromJson( Map<String, dynamic> json) => PrevyearpaperSubjectsResponse(
    statusCode: json["status_code"],
    message: json["message"],
    previousYearTestList: json["previous_year_test_list"] == null ? [] : List<PrevYrSubject>.from(json["previous_year_test_list"]!.map((x) => PrevYrSubject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "previous_year_test_list": previousYearTestList == null ? [] : List<dynamic>.from(previousYearTestList!.map((x) => x.toJson())),
  };
}

class PrevYrSubject {
  String? subCatId;
  String? subCategoryName;
  String? subCatImg;
  List<PrevYrSubjectSubcat>? sectionList;

  PrevYrSubject({
    this.subCatId,
    this.subCategoryName,
    this.subCatImg,
    this.sectionList,
  });

  factory PrevYrSubject.fromJson(Map<String, dynamic> json) => PrevYrSubject(
    subCatId: json["sub_cat_id"],
    subCategoryName: json["sub_category_name"],
    subCatImg: json["sub_cat_img "],
    sectionList: json["section_list"] == null ? [] : List<PrevYrSubjectSubcat>.from(json["section_list"]!.map((x) => PrevYrSubjectSubcat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sub_cat_id": subCatId,
    "sub_category_name": subCategoryName,
    "sub_cat_img ": subCatImg,
    "section_list": sectionList == null ? [] : List<dynamic>.from(sectionList!.map((x) => x.toJson())),
  };
}

class PrevYrSubjectSubcat {
  String? sectionId;
  String? sectionName;

  PrevYrSubjectSubcat({
    this.sectionId,
    this.sectionName,
  });

  factory PrevYrSubjectSubcat.fromJson(Map<String, dynamic> json) => PrevYrSubjectSubcat(
    sectionId: json["section_id"],
    sectionName: json["section_name"],
  );

  Map<String, dynamic> toJson() => {
    "section_id": sectionId,
    "section_name": sectionName,
  };
}
