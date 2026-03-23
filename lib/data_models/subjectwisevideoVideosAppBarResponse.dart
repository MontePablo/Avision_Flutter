class SubjectWiseVideoVideosAppBarResponsse {
  int? status;
  String? msg;
  List<SubjectWiseVideo>? subjectWiseVideos;

  SubjectWiseVideoVideosAppBarResponsse({
    this.status,
    this.msg,
    this.subjectWiseVideos,
  });

  factory SubjectWiseVideoVideosAppBarResponsse.fromJson(Map<String, dynamic> json) => SubjectWiseVideoVideosAppBarResponsse(
    status: json["status"],
    msg: json["msg"],
    subjectWiseVideos: json["subject_wise_videos"] == null ? [] : List<SubjectWiseVideo>.from(json["subject_wise_videos"]!.map((x) => SubjectWiseVideo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "subject_wise_videos": subjectWiseVideos == null ? [] : List<dynamic>.from(subjectWiseVideos!.map((x) => x.toJson())),
  };
}

class SubjectWiseVideo {
  String? subjectId;
  String? subjectName;
  List<Video>? videosList;
  int? videoCount;

  SubjectWiseVideo({
    this.subjectId,
    this.subjectName,
    this.videosList,
    this.videoCount,
  });

  factory SubjectWiseVideo.fromJson(Map<String, dynamic> json) => SubjectWiseVideo(
    subjectId: json["subject_id"],
    subjectName: json["subject_name"],
    videosList: json["videos_list"] == null ? [] : List<Video>.from(json["videos_list"]!.map((x) => Video.fromJson(x))),
    videoCount: json["video_count"],
  );

  Map<String, dynamic> toJson() => {
    "subject_id": subjectId,
    "subject_name": subjectName,
    "videos_list": videosList == null ? [] : List<dynamic>.from(videosList!.map((x) => x.toJson())),
    "video_count": videoCount,
  };
}

class Video {
  String? typeId;
  String? typeName;
  String? videoId;
  String? videoName;
  String? videoLink;
  String? videoCode;
  String? subjectId;
  String? trendingStat;
  String? videoStatus;
  DateTime? createdDate;
  DateTime? modifiedDate;
  String? videoImg;
  dynamic seenStatus;
  dynamic ellapsedTime;
  dynamic totalDuration;

  Video({
    this.typeId,
    this.typeName,
    this.videoId,
    this.videoName,
    this.videoLink,
    this.videoCode,
    this.subjectId,
    this.trendingStat,
    this.videoStatus,
    this.createdDate,
    this.modifiedDate,
    this.videoImg,
    this.seenStatus,
    this.ellapsedTime,
    this.totalDuration,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    typeId: json["type_id"],
    typeName: json["type_name"],
    videoId: json["video_id"],
    videoName: json["video_name"],
    videoLink: json["video_link"],
    videoCode: json["video_code"],
    subjectId: json["subject_id"],
    trendingStat: json["trending_stat"],
    videoStatus: json["video_status"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    modifiedDate: json["modified_date"] == null ? null : DateTime.parse(json["modified_date"]),
    videoImg: json["video_img"],
    seenStatus: json["seen_status"],
    ellapsedTime: json["ellapsed_time"],
    totalDuration: json["total_duration"],
  );

  Map<String, dynamic> toJson() => {
    "type_id": typeId,
    "type_name": typeName,
    "video_id": videoId,
    "video_name": videoName,
    "video_link": videoLink,
    "video_code": videoCode,
    "subject_id": subjectId,
    "trending_stat": trendingStat,
    "video_status": videoStatus,
    "created_date": "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
    "modified_date": modifiedDate?.toIso8601String(),
    "video_img": videoImg,
    "seen_status": seenStatus,
    "ellapsed_time": ellapsedTime,
    "total_duration": totalDuration,
  };
}
