class NewsListNewsAppbarResponse {
  String? statusCode;
  String? message;
  NewsAnalysis? newsAnalysis;

  NewsListNewsAppbarResponse({
    this.statusCode,
    this.message,
    this.newsAnalysis,
  });

  factory NewsListNewsAppbarResponse.fromJson(Map<String, dynamic> json) => NewsListNewsAppbarResponse(
    statusCode: json["status_code"],
    message: json["message"],
    newsAnalysis: json["news_analysis"] == null ? null : NewsAnalysis.fromJson(json["news_analysis"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "news_analysis": newsAnalysis?.toJson(),
  };
}

class NewsAnalysis {
  List<News>? titleContent;
  List<DatUrl>? datUrl;

  NewsAnalysis({
    this.titleContent,
    this.datUrl,
  });

  factory NewsAnalysis.fromJson(Map<String, dynamic> json) => NewsAnalysis(
    titleContent: json["title_content"] == null ? [] : List<News>.from(json["title_content"]!.map((x) => News.fromJson(x))),
    datUrl: json["dat_url"] == null ? [] : List<DatUrl>.from(json["dat_url"]!.map((x) => DatUrl.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title_content": titleContent == null ? [] : List<dynamic>.from(titleContent!.map((x) => x.toJson())),
    "dat_url": datUrl == null ? [] : List<dynamic>.from(datUrl!.map((x) => x.toJson())),
  };
}

class DatUrl {
  DateTime? postedDate;
  String? pdfUrl;

  DatUrl({
    this.postedDate,
    this.pdfUrl,
  });

  factory DatUrl.fromJson(Map<String, dynamic> json) => DatUrl(
    postedDate: json["posted_date"] == null ? null : DateTime.parse(json["posted_date"]),
    pdfUrl: json["pdf_url"],
  );

  Map<String, dynamic> toJson() => {
    "posted_date": "${postedDate!.year.toString().padLeft(4, '0')}-${postedDate!.month.toString().padLeft(2, '0')}-${postedDate!.day.toString().padLeft(2, '0')}",
    "pdf_url": pdfUrl,
  };
}

class News {
  String? title;
  String? content;
  String? imageUrl;

  News({
    this.title,
    this.content,
    this.imageUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    title: json["title"],
    content: json["content"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
    "image_url": imageUrl,
  };
}
