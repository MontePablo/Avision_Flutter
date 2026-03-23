class ExamListTestSeriesResponse {
  String? statusCode;
  String? message;
  List<TestSeries>? testSeries;

  ExamListTestSeriesResponse({
    this.statusCode,
    this.message,
    this.testSeries,
  });

  factory ExamListTestSeriesResponse.fromJson(Map<String, dynamic> json) => ExamListTestSeriesResponse(
    statusCode: json["status_code"],
    message: json["message"],
    testSeries: json["test_series"] == null ? [] : List<TestSeries>.from(json["test_series"]!.map((x) => TestSeries.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "test_series": testSeries == null ? [] : List<dynamic>.from(testSeries!.map((x) => x.toJson())),
  };
}

class TestSeries {
  String? testSeriesName;
  String? testSeriesImage;
  String? testSeriesSectionName;
  String? testSeriesTotalTest;
  int? fullTestCount;
  int? sectionalTestCount;
  int? previousYearTestCount;
  String? testSeriesValidity;
  String? testSeriesOrgPrice;
  String? testSeriesOfferPrice;
  String? testSeriesId;
  String? link;

  TestSeries({
    this.testSeriesName,
    this.testSeriesImage,
    this.testSeriesSectionName,
    this.testSeriesTotalTest,
    this.fullTestCount,
    this.sectionalTestCount,
    this.previousYearTestCount,
    this.testSeriesValidity,
    this.testSeriesOrgPrice,
    this.testSeriesOfferPrice,
    this.testSeriesId,
    this.link,
  });

  factory TestSeries.fromJson(Map<String, dynamic> json) => TestSeries(
    testSeriesName: json["test_series_name"],
    testSeriesImage: json["test_series_image"],
    testSeriesSectionName: json["test_series_section_name"],
    testSeriesTotalTest: json["test_series_total_test"],
    fullTestCount: json["full_test_count"],
    sectionalTestCount: json["sectional_test_count"],
    previousYearTestCount: json["previous_year_test_count"],
    testSeriesValidity: json["test_series_validity"],
    testSeriesOrgPrice: json["test_series_org_price"],
    testSeriesOfferPrice: json["test_series_offer_price"],
    testSeriesId: json["test_series_id"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "test_series_name": testSeriesName,
    "test_series_image": testSeriesImage,
    "test_series_section_name": testSeriesSectionName,
    "test_series_total_test": testSeriesTotalTest,
    "full_test_count": fullTestCount,
    "sectional_test_count": sectionalTestCount,
    "previous_year_test_count": previousYearTestCount,
    "test_series_validity": testSeriesValidity,
    "test_series_org_price": testSeriesOrgPrice,
    "test_series_offer_price": testSeriesOfferPrice,
    "test_series_id": testSeriesId,
    "link": link,
  };
}
