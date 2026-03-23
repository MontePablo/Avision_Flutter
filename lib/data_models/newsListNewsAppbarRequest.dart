import 'package:flutter/cupertino.dart';
class NewsListNewsAppbarRequest {
  String detailsDate;

  NewsListNewsAppbarRequest({
    required this.detailsDate,
  });

  factory NewsListNewsAppbarRequest.fromJson(Map<String, dynamic> json) => NewsListNewsAppbarRequest(
    detailsDate: json["details_date"],
  );

  Map<String, dynamic> toJson() => {
    "details_date": detailsDate,
  };
}
