import 'package:avision/data_models/subjectwisevideoVideosAppBarResponse.dart';

class TrendingVideoVideosAppBarResponse {
  int? status;
  String? msg;
  List<Video>? latestVideos;

  TrendingVideoVideosAppBarResponse({
    this.status,
    this.msg,
    this.latestVideos,
  });

  factory TrendingVideoVideosAppBarResponse.fromJson(Map<String, dynamic> json) => TrendingVideoVideosAppBarResponse(
    status: json["status"],
    msg: json["msg"],
    latestVideos: json["latest_videos"] == null ? [] : List<Video>.from(json["latest_videos"]!.map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "latest_videos": latestVideos == null ? [] : List<dynamic>.from(latestVideos!.map((x) => x.toJson())),
  };
}
