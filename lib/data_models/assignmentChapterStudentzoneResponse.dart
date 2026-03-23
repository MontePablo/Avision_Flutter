class AssignmentChapterStudentzoneResponse {
  int? status;
  String? msg;
  List<AssignmentChapter>? files;

  AssignmentChapterStudentzoneResponse({
    this.status,
    this.msg,
    this.files,
  });

  factory AssignmentChapterStudentzoneResponse.fromJson(Map<String, dynamic> json) => AssignmentChapterStudentzoneResponse(
    status: json["status"],
    msg: json["msg"],
    files: json["files"] == null ? [] : List<AssignmentChapter>.from(json["files"]!.map((x) => AssignmentChapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x.toJson())),
  };
}

class AssignmentChapter {
  String? assignmentName;
  String? fileUrl;

  AssignmentChapter({
    this.assignmentName,
    this.fileUrl,
  });

  factory AssignmentChapter.fromJson(Map<String, dynamic> json) => AssignmentChapter(
    assignmentName: json["assignment_name"],
    fileUrl: json["file_url"],
  );

  Map<String, dynamic> toJson() => {
    "assignment_name": assignmentName,
    "file_url": fileUrl,
  };
}
