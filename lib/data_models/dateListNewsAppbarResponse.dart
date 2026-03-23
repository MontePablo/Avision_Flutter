class DateListNewsAppbarResponse {
  String? statusCode;
  String? message;
  List<NewsDate>? newsAnalysis;

  DateListNewsAppbarResponse({
    this.statusCode,
    this.message,
    this.newsAnalysis,
  });

  factory DateListNewsAppbarResponse.fromJson(Map<String, dynamic> json) => DateListNewsAppbarResponse(
    statusCode: json["status_code"],
    message: json["message"],
    newsAnalysis: json["news_analysis"] == null ? [] : List<NewsDate>.from(json["news_analysis"]!.map((x) => NewsDate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "news_analysis": newsAnalysis == null ? [] : List<dynamic>.from(newsAnalysis!.map((x) => x.toJson())),
  };
}

class NewsDate {
  String? id;
  DateTime? postedDate;

  NewsDate({
    this.id,
    this.postedDate,
  });

  factory NewsDate.fromJson(Map<String, dynamic> json) => NewsDate(
    id: json["_id"],
    postedDate: json["posted_date"] == null ? null : DateTime.parse(json["posted_date"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "posted_date": "${postedDate!.year.toString().padLeft(4, '0')}-${postedDate!.month.toString().padLeft(2, '0')}-${postedDate!.day.toString().padLeft(2, '0')}",
  };
}
