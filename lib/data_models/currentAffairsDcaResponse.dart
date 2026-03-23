import 'multiApiOneHomeResponse.dart';

class CurrentAffairsDcaResponse {
  String? statusCode;
  String? message;
  NewsAnalysisCurrentAffairDca? newsAnalysis;

  CurrentAffairsDcaResponse({
    this.statusCode,
    this.message,
    this.newsAnalysis,
  });

  factory CurrentAffairsDcaResponse.fromJson(Map<String, dynamic> json) => CurrentAffairsDcaResponse(
    statusCode: json["status_code"],
    message: json["message"],
    newsAnalysis: json["news_analysis"] == null ? null : NewsAnalysisCurrentAffairDca.fromJson(json["news_analysis"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "news_analysis": newsAnalysis?.toJson(),
  };
}
class NewsAnalysisCurrentAffairDca {
  List<CurrentAffairHomeDca>? currentAffairs;

  NewsAnalysisCurrentAffairDca({
    this.currentAffairs,
  });

  factory NewsAnalysisCurrentAffairDca.fromJson(Map<String, dynamic> json) => NewsAnalysisCurrentAffairDca(
    currentAffairs: json["current_affairs"] == null ? [] : List<CurrentAffairHomeDca>.from(json["current_affairs"]!.map((x) => CurrentAffairHomeDca.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "current_affairs": currentAffairs == null ? [] : List<dynamic>.from(currentAffairs!.map((x) => x.toJson())),
  };
}

class CurrentAffairHomeDca {
  String? id;
  String? postTitle;
  String? postContent;
  String? metaValue;

  CurrentAffairHomeDca({
    this.id,
    this.postTitle,
    this.postContent,
    this.metaValue,
  });

  factory CurrentAffairHomeDca.fromJson(Map<String, dynamic> json) => CurrentAffairHomeDca(
    id: json["ID"],
    postTitle: json["post_title"],
    postContent: json["post_content"],
    metaValue: json["meta_value"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "post_title": postTitle,
    "post_content": postContent,
    "meta_value": metaValue,
  };
}