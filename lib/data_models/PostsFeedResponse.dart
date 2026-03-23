import 'multiApiTwoHomeResponse.dart';

class PostsFeedResponse {
  int? status;
  String? msg;
  List<Post>? postArray;
  int? postCount;

  PostsFeedResponse({
    this.status,
    this.msg,
    this.postArray,
    this.postCount,
  });

  factory PostsFeedResponse.fromJson(Map<String, dynamic> json) => PostsFeedResponse(
    status: json["status"],
    msg: json["msg"],
    postArray: json["post_array"] == null ? [] : List<Post>.from(json["post_array"]!.map((x) => Post.fromJson(x))),
    postCount: json["post_count"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "post_array": postArray == null ? [] : List<dynamic>.from(postArray!.map((x) => x.toJson())),
    "post_count": postCount,
  };
}
