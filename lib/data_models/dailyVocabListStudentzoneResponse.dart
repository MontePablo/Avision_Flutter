class DailyVocabListStudentzoneResponse {
  String? statusCode;
  String? message;
  List<Vocab>? result;

  DailyVocabListStudentzoneResponse({
    this.statusCode,
    this.message,
    this.result,
  });

  factory DailyVocabListStudentzoneResponse.fromJson(Map<String, dynamic> json) => DailyVocabListStudentzoneResponse(
    statusCode: json["status_code"],
    message: json["message"],
    result: json["result"] == null ? [] : List<Vocab>.from(json["result"]!.map((x) => Vocab.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Vocab {
  String? title;
  String? id;
  String? image;

  Vocab({
    this.title,
    this.id,
    this.image,
  });

  factory Vocab.fromJson(Map<String, dynamic> json) => Vocab(
    title: json["title"],
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "image": image,
  };
}
