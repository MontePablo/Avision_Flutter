import 'package:avision/data_models/subjectwisevideoVideosAppBarResponse.dart';

class SubjectwiseAllvideoVideosAppBarResponse {
  int? status;
  String? msg;
  List<Video>? subjectWiseVideos;

  SubjectwiseAllvideoVideosAppBarResponse({
    this.status,
    this.msg,
    this.subjectWiseVideos,
  });

  factory SubjectwiseAllvideoVideosAppBarResponse.fromJson(Map<String, dynamic> json) => SubjectwiseAllvideoVideosAppBarResponse(
    status: json["status"],
    msg: json["msg"],
    subjectWiseVideos: json["subject_wise_videos"] == null ? [] : List<Video>.from(json["subject_wise_videos"]!.map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "subject_wise_videos": subjectWiseVideos == null ? [] : List<dynamic>.from(subjectWiseVideos!.map((x) => x.toJson())),
  };
}