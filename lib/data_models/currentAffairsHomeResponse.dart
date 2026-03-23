import 'multiApiOneHomeResponse.dart';

class CurrentAffairsHomeResponse {
  String? statusCode;
  String? message;
  NewsAnalysisCurrentAffairsHome? newsAnalysis;

  CurrentAffairsHomeResponse({
    this.statusCode,
    this.message,
    this.newsAnalysis,
  });

  factory CurrentAffairsHomeResponse.fromJson(Map<String, dynamic> json) => CurrentAffairsHomeResponse(
    statusCode: json["status_code"],
    message: json["message"],
    newsAnalysis: json["news_analysis"] == null ? null : NewsAnalysisCurrentAffairsHome.fromJson(json["news_analysis"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "news_analysis": newsAnalysis?.toJson(),
  };
}
class NewsAnalysisCurrentAffairsHome {
  List<CurrentAffairHomeDca>? currentAffairsOne;

  NewsAnalysisCurrentAffairsHome({
    this.currentAffairsOne,
  });

  factory NewsAnalysisCurrentAffairsHome.fromJson(Map<String, dynamic> json) => NewsAnalysisCurrentAffairsHome(
    currentAffairsOne: json["current_affairs_one"] == null ? [] : List<CurrentAffairHomeDca>.from(json["current_affairs_one"]!.map((x) => CurrentAffairHomeDca.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "current_affairs_one": currentAffairsOne == null ? [] : List<dynamic>.from(currentAffairsOne!.map((x) => x.toJson())),
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