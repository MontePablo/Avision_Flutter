class PopularCourseResponse {
  String? statusCode;
  String? message;
  List<PopularCourse>? popularCourse;

  PopularCourseResponse({
    this.statusCode,
    this.message,
    this.popularCourse,
  });

  factory PopularCourseResponse.fromJson(Map<String, dynamic> json) => PopularCourseResponse(
    statusCode: json["status_code"],
    message: json["message"],
    popularCourse: json["popular_course"] == null ? [] : List<PopularCourse>.from(json["popular_course"]!.map((x) => PopularCourse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "popular_course": popularCourse == null ? [] : List<dynamic>.from(popularCourse!.map((x) => x.toJson())),
  };
}

class PopularCourse {
  String? productId;
  String? productName;
  String? productPrice;
  String? productOfferPrice;
  String? productImage;
  String? productType;
  String? courseDuration;

  PopularCourse({
    this.productId,
    this.productName,
    this.productPrice,
    this.productOfferPrice,
    this.productImage,
    this.productType,
    this.courseDuration,
  });

  factory PopularCourse.fromJson(Map<String, dynamic> json) => PopularCourse(
    productId: json["product_id"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productOfferPrice: json["product_offer_price"],
    productImage: json["product_image"],
    productType: json["product_type"],
    courseDuration: json["course_duration"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "product_price": productPrice,
    "product_offer_price": productOfferPrice,
    "product_image": productImage,
    "product_type": productType,
    "course_duration": courseDuration,
  };
}
