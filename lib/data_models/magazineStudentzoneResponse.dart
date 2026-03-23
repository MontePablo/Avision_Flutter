class MagazineBoosterGaStudentzoneResponse {
  String? statusCode;
  String? message;
  List<Magazine>? magagineList;

  MagazineBoosterGaStudentzoneResponse({
    this.statusCode,
    this.message,
    this.magagineList,
  });

  factory MagazineBoosterGaStudentzoneResponse.fromJson(Map<String, dynamic> json) => MagazineBoosterGaStudentzoneResponse(
    statusCode: json["status_code"],
    message: json["message"],
    magagineList: json["magagine_list"] == null ? [] : List<Magazine>.from(json["magagine_list"]!.map((x) => Magazine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "magagine_list": magagineList == null ? [] : List<dynamic>.from(magagineList!.map((x) => x.toJson())),
  };
}

class Magazine {
  String? magagineTitle;
  String? magagineLink;
  String? magagineDate;
  String? magagineImg;
  String? pdfLang;

  Magazine({
    this.magagineTitle,
    this.magagineLink,
    this.magagineDate,
    this.magagineImg,
    this.pdfLang,
  });

  factory Magazine.fromJson(Map<String, dynamic> json) => Magazine(
    magagineTitle: json["magagine_title"],
    magagineLink: json["magagine_link"],
    magagineDate: json["magagine_date"],
    magagineImg: json["magagine_img"],
    pdfLang: json["pdf_lang"],
  );

  Map<String, dynamic> toJson() => {
    "magagine_title": magagineTitle,
    "magagine_link": magagineLink,
    "magagine_date": magagineDate,
    "magagine_img": magagineImg,
    "pdf_lang": pdfLang,
  };
}
