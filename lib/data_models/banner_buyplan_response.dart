import 'package:avision/data_models/multiapiBannerResponse.dart';

class BannerBuyplanResponse {
  String? statusCode;
  String? message;
  List<SingleBanner>? banner;

  BannerBuyplanResponse({
    this.statusCode,
    this.message,
    this.banner,
  });

  factory BannerBuyplanResponse.fromJson(Map<String, dynamic> json) => BannerBuyplanResponse(
    statusCode: json["status_code"],
    message: json["message"],
    banner: json["banner"] == null ? [] : List<SingleBanner>.from(json["banner"]!.map((x) => SingleBanner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "banner": banner == null ? [] : List<dynamic>.from(banner!.map((x) => x.toJson())),
  };
}