class QuizRankResponse {
  int? statusCode;
  String? message;
  RankInfo? rankInfo;

  QuizRankResponse({
    this.statusCode,
    this.message,
    this.rankInfo,
  });

  factory QuizRankResponse.fromJson(Map<String, dynamic> json) => QuizRankResponse(
    statusCode: json["status_code"],
    message: json["message"],
    rankInfo: json["rank_info"] == null ? null : RankInfo.fromJson(json["rank_info"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "rank_info": rankInfo?.toJson(),
  };
}

class RankInfo {
  int? studentRank;
  int? totalStudent;
  List<StudentRank>? studentArr;

  RankInfo({
    this.studentRank,
    this.totalStudent,
    this.studentArr,
  });

  factory RankInfo.fromJson(Map<String, dynamic> json) => RankInfo(
    studentRank: json["student_rank"],
    totalStudent: json["total_student"],
    studentArr: json["sudent_arr"] == null ? [] : List<StudentRank>.from(json["sudent_arr"].map((x) => StudentRank.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "student_rank": studentRank,
    "total_student": totalStudent,
    "sudent_arr": studentArr == null ? [] : List<dynamic>.from(studentArr!.map((x) => x.toJson())),
  };
}

class StudentRank {
  String? userName;
  String? userImage;
  int? rank;
  String? attempted;

  StudentRank({
    this.userName,
    this.userImage,
    this.rank,
    this.attempted,
  });

  factory StudentRank.fromJson(Map<String, dynamic> json) => StudentRank(
    userName: json["user_name"],
    userImage: json["user_image"],
    rank: json["rank"],
    attempted: json["attempted"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "user_image": userImage,
    "rank": rank,
    "attempted": attempted,
  };
}
