import 'package:avision/data_models/subjectwisevideoVideosAppBarResponse.dart';

class RecordedVideosDrawerResponse {
  String? statusCode;
  String? message;
  List<Video>? videoDtls;

  RecordedVideosDrawerResponse({
    this.statusCode,
    this.message,
    this.videoDtls,
  });

  factory RecordedVideosDrawerResponse.fromJson(Map<String, dynamic> json) => RecordedVideosDrawerResponse(
    statusCode: json["status_code"],
    message: json["message"],
    videoDtls: json["video_dtls"] == null ? [] : List<Video>.from(json["video_dtls"]!.map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "video_dtls": videoDtls == null ? [] : List<dynamic>.from(videoDtls!.map((x) => x.toJson())),
  };
}
