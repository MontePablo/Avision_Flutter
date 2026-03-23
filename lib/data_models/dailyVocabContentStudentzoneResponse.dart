class DailyVocabContentStudentzoneResponse {
  String? statusCode;
  String? message;
  DailyVocabList? dailyVocabList;

  DailyVocabContentStudentzoneResponse({
    this.statusCode,
    this.message,
    this.dailyVocabList,
  });

  factory DailyVocabContentStudentzoneResponse.fromJson(Map<String, dynamic> json) => DailyVocabContentStudentzoneResponse(
    statusCode: json["status_code"],
    message: json["message"],
    dailyVocabList: json["daily_vocab_list"] == null ? null : DailyVocabList.fromJson(json["daily_vocab_list"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "daily_vocab_list": dailyVocabList?.toJson(),
  };
}

class DailyVocabList {
  String? postContent;
  String? postTitle;
  String? pdfLink;

  DailyVocabList({
    this.postContent,
    this.postTitle,
    this.pdfLink,
  });

  factory DailyVocabList.fromJson(Map<String, dynamic> json) => DailyVocabList(
    postContent: json["post_content"],
    postTitle: json["post_title"],
    pdfLink: json["pdf_link"],
  );

  Map<String, dynamic> toJson() => {
    "post_content": postContent,
    "post_title": postTitle,
    "pdf_link": pdfLink,
  };
}
