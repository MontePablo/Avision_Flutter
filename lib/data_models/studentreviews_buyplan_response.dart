class StudentreviewsBuyplanResponse {
  String? statusCode;
  String? message;
  List<StudentReview>? result;

  StudentreviewsBuyplanResponse({
    this.statusCode,
    this.message,
    this.result,
  });

  factory StudentreviewsBuyplanResponse.fromJson(Map<String, dynamic> json) => StudentreviewsBuyplanResponse(
    statusCode: json["status_code"],
    message: json["message"],
    result: json["result"] == null ? [] : List<StudentReview>.from(json["result"]!.map((x) => StudentReview.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class StudentReview {
  String? studentName;
  String? rating;
  String? reviewDetails;
  String? image;

  StudentReview({
    this.studentName,
    this.rating,
    this.reviewDetails,
    this.image,
  });

  factory StudentReview.fromJson(Map<String, dynamic> json) => StudentReview(
    studentName: json["student_name"],
    rating: json["rating"],
    reviewDetails: json["review_details"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "student_name": studentName,
    "rating": rating,
    "review_details": reviewDetails,
    "image": image,
  };
}
