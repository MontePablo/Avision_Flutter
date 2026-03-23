import 'package:avision/data_models/multiApiLiveCourseResponse.dart';

import 'multiApiOneHomeResponse.dart';

class MultiApiBannerResponse {
  String? statusCode;
  String? message;
  SingleBanner? banner;

  MultiApiBannerResponse({
    this.statusCode,
    this.message,
    this.banner,
  });

  factory MultiApiBannerResponse.fromJson(Map<String, dynamic> json) => MultiApiBannerResponse(
    statusCode: json["status_code"],
    message: json["message"],
    banner: json["banner"] == null ? null : SingleBanner.fromJson(json["banner"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "banner": banner?.toJson(),
  };
}
class SingleBanner {
  String? bannerImage;
  String? pdfLink;

  SingleBanner({
    this.bannerImage,
    this.pdfLink
  });

  factory SingleBanner.fromJson(Map<String, dynamic> json) => SingleBanner(
      bannerImage: json["banner_image"],
      pdfLink: json["pdf_link"]
  );

  Map<String, dynamic> toJson() => {
    "banner_image": bannerImage,
    "pdf_link": pdfLink,
  };
}

