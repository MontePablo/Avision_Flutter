class AssignmentSubjectStudentzoneResponse {
  int? status;
  String? msg;
  List<AssignmentSubject>? subjectList;

  AssignmentSubjectStudentzoneResponse({
    this.status,
    this.msg,
    this.subjectList,
  });

  factory AssignmentSubjectStudentzoneResponse.fromJson(Map<String, dynamic> json) => AssignmentSubjectStudentzoneResponse(
    status: json["status"],
    msg: json["msg"],
    subjectList: json["subject_list"] == null ? [] : List<AssignmentSubject>.from(json["subject_list"]!.map((x) => AssignmentSubject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "subject_list": subjectList == null ? [] : List<dynamic>.from(subjectList!.map((x) => x.toJson())),
  };
}

class AssignmentSubject {
  String? typeId;
  String? typeName;

  AssignmentSubject({
    this.typeId,
    this.typeName,
  });

  factory AssignmentSubject.fromJson(Map<String, dynamic> json) => AssignmentSubject(
    typeId: json["type_id"],
    typeName: json["type_name"],
  );

  Map<String, dynamic> toJson() => {
    "type_id": typeId,
    "type_name": typeName,
  };
}
