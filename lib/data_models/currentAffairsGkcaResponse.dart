class CurrentAffairsGkcaResponse {
  String? statusCode;
  List<CurrentAffairGkca>? message;

  CurrentAffairsGkcaResponse({
    this.statusCode,
    this.message,
  });

  factory CurrentAffairsGkcaResponse.fromJson(Map<String, dynamic> json) => CurrentAffairsGkcaResponse(
    statusCode: json["status_code"],
    message: json["message"] == null ? [] : List<CurrentAffairGkca>.from(json["message"]!.map((x) => CurrentAffairGkca.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x.toJson())),
  };
}

class CurrentAffairGkca {
  String? postId;
  String? postTitle;
  String? postContent;
  String? postType;
  String? postDate;
  String? shareLink;

  CurrentAffairGkca({
    this.postId,
    this.postTitle,
    this.postContent,
    this.postType,
    this.postDate,
    this.shareLink,
  });

  factory CurrentAffairGkca.fromJson(Map<String, dynamic> json) =>
      CurrentAffairGkca(
        postId: json["post_id"],
        postTitle: json["post_title"],
        postContent: json["post_content"],
        postType: json["post_type"],
        postDate: json["post_date"],
        shareLink: json["share_link"],
      );

  Map<String, dynamic> toJson() =>
      {
        "post_id": postId,
        "post_title": postTitle,
        "post_content": postContent,
        "post_type": postType,
        "post_date": postDate,
        "share_link": shareLink,
      };
}