import 'multiapiBannerResponse.dart';

class MultiApiOneHomeResponse {
  String? statusCode;
  String? message;
  NewsAnalysis? newsAnalysis;

  MultiApiOneHomeResponse({
    this.statusCode,
    this.message,
    this.newsAnalysis,
  });

  factory MultiApiOneHomeResponse.fromJson(Map<String, dynamic> json) => MultiApiOneHomeResponse(
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
  List<SingleBanner>? bannerFetch;
  List<TrendingTest>? trendingTest;
  List<CurrentAffairMultiapione>? currentAffairs;
  List<SingleBanner>? planBanner;

  NewsAnalysis({
    this.bannerFetch,
    this.trendingTest,
    this.currentAffairs,
    this.planBanner,
  });

  factory NewsAnalysis.fromJson(Map<String, dynamic> json) => NewsAnalysis(
    bannerFetch: json["banner_fetch"] == null ? [] : List<SingleBanner>.from(json["banner_fetch"]!.map((x) => SingleBanner.fromJson(x))),
    trendingTest: json["trending_test"] == null ? [] : List<TrendingTest>.from(json["trending_test"]!.map((x) => TrendingTest.fromJson(x))),
    currentAffairs: json["current_affairs"] == null ? [] : List<CurrentAffairMultiapione>.from(json["current_affairs"]!.map((x) => CurrentAffairMultiapione.fromJson(x))),
    planBanner: json["plan_banner"] == null ? [] : List<SingleBanner>.from(json["plan_banner"]!.map((x) => SingleBanner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "banner_fetch": bannerFetch == null ? [] : List<dynamic>.from(bannerFetch!.map((x) => x.toJson())),
    "trending_test": trendingTest == null ? [] : List<dynamic>.from(trendingTest!.map((x) => x.toJson())),
    "current_affairs": currentAffairs == null ? [] : List<dynamic>.from(currentAffairs!.map((x) => x.toJson())),
    "plan_banner": planBanner == null ? [] : List<dynamic>.from(planBanner!.map((x) => x.toJson())),
  };
}

class CurrentAffairMultiapione {
  String? id;
  String? postTitle;
  List<String>? metaValue;
  DateTime? postedDate;
  int? status;
  bool isExpanded=false;
  CurrentAffairMultiapione({
    this.id,
    this.postTitle,
    this.metaValue,
    this.postedDate,
    this.status,
  });

  factory CurrentAffairMultiapione.fromJson(Map<String, dynamic> json) => CurrentAffairMultiapione(
    id: json["ID"],
    postTitle: json["post_title"],
    metaValue: json["meta_value"] == null ? [] : List<String>.from(json["meta_value"]!.map((x) => x)),
    postedDate: json["posted_date"] == null ? null : DateTime.parse(json["posted_date"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "post_title": postTitle,
    "meta_value": metaValue == null ? [] : List<dynamic>.from(metaValue!.map((x) => x)),
    "posted_date": "${postedDate!.year.toString().padLeft(4, '0')}-${postedDate!.month.toString().padLeft(2, '0')}-${postedDate!.day.toString().padLeft(2, '0')}",
    "status": status,
  };
}


class TrendingTest {
  String? subCategoryId;
  String? subCategoryName;
  String? subCategoryImage;
  String? courseId;
  dynamic productId;
  String? sectionName;

  TrendingTest({
    this.subCategoryId,
    this.subCategoryName,
    this.subCategoryImage,
    this.courseId,
    this.productId,
    this.sectionName,
  });

  factory TrendingTest.fromJson(Map<String, dynamic> json) => TrendingTest(
    subCategoryId: json["sub_category_id"],
    subCategoryName: json["sub_category_name"],
    subCategoryImage: json["sub_category_image"],
    courseId: json["course_id"],
    productId: json["product_id"],
    sectionName: json["section_name"],
  );

  Map<String, dynamic> toJson() => {
    "sub_category_id": subCategoryId,
    "sub_category_name": subCategoryName,
    "sub_category_image": subCategoryImage,
    "course_id": courseId,
    "product_id": productId,
    "section_name": sectionName,
  };
}
