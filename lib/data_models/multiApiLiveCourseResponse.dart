import 'package:avision/data_models/multiApiOneHomeResponse.dart';

import 'multiapiBannerResponse.dart';

class MultiApiLiveCourseResponse {
  String? statusCode;
  String? message;
  Result? result;

  MultiApiLiveCourseResponse({
    this.statusCode,
    this.message,
    this.result,
  });

  factory MultiApiLiveCourseResponse.fromJson(Map<String, dynamic> json) => MultiApiLiveCourseResponse(
    statusCode: json["status_code"],
    message: json["message"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
  List<TeachersDetail>? teachersDetails;
  List<dynamic>? review;
  List<SingleBanner>? banner;
  List<Course>? courseApi;

  Result({
    this.teachersDetails,
    this.review,
    this.banner,
    this.courseApi,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    teachersDetails: json["teachers_details"] == null ? [] : List<TeachersDetail>.from(json["teachers_details"]!.map((x) => TeachersDetail.fromJson(x))),
    review: json["review"] == null ? [] : List<dynamic>.from(json["review"]!.map((x) => x)),
    banner: json["banner"] == null ? [] : List<SingleBanner>.from(json["banner"]!.map((x) => SingleBanner.fromJson(x))),
    courseApi: json["course_api"] == null ? [] : List<Course>.from(json["course_api"]!.map((x) => Course.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "teachers_details": teachersDetails == null ? [] : List<dynamic>.from(teachersDetails!.map((x) => x.toJson())),
    "review": review == null ? [] : List<dynamic>.from(review!.map((x) => x)),
    "banner": banner == null ? [] : List<dynamic>.from(banner!.map((x) => x.toJson())),
    "course_api": courseApi == null ? [] : List<dynamic>.from(courseApi!.map((x) => x.toJson())),
  };
}

class Course {
  String? courseId;
  String? courseTitle;
  String? liveClass;
  String? mockTest;
  String? pdfNotes;
  String? practiceQuestion;
  String? courseImage;
  DateTime? courseStartDate;
  String? coursePrice;
  String? courseOfferPrice;
  String? validity;
  String? productType;

  Course({
    this.courseId,
    this.courseTitle,
    this.liveClass,
    this.mockTest,
    this.pdfNotes,
    this.practiceQuestion,
    this.courseImage,
    this.courseStartDate,
    this.coursePrice,
    this.courseOfferPrice,
    this.validity,
    this.productType,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    courseId: json["course_id"],
    courseTitle: json["course_title"],
    liveClass: json["live_class"],
    mockTest: json["mock_test"],
    pdfNotes: json["pdf_notes"],
    practiceQuestion: json["practice_question"],
    courseImage: json["course_image"],
    courseStartDate: json["course_start_date"] == null ? null : DateTime.parse(json["course_start_date"]),
    coursePrice: json["course_price"],
    courseOfferPrice: json["course_offer_price"],
    validity: json["validity"],
    productType: json["product_type"],
  );

  Map<String, dynamic> toJson() => {
    "course_id": courseId,
    "course_title": courseTitle,
    "live_class": liveClass,
    "mock_test": mockTest,
    "pdf_notes": pdfNotes,
    "practice_question": practiceQuestion,
    "course_image": courseImage,
    "course_start_date": "${courseStartDate!.year.toString().padLeft(4, '0')}-${courseStartDate!.month.toString().padLeft(2, '0')}-${courseStartDate!.day.toString().padLeft(2, '0')}",
    "course_price": coursePrice,
    "course_offer_price": courseOfferPrice,
    "validity": validity,
    "product_type": productType,
  };
}

class TeachersDetail {
  String? id;
  String? teacherName;
  String? qualification;
  String? teacherSpecialization;
  String? teacherExperience;
  String? teacherImage;

  TeachersDetail({
    this.id,
    this.teacherName,
    this.qualification,
    this.teacherSpecialization,
    this.teacherExperience,
    this.teacherImage,
  });

  factory TeachersDetail.fromJson(Map<String, dynamic> json) =>
      TeachersDetail(
        id: json["id"],
        teacherName: json["teacher_name"],
        qualification: json["qualification"],
        teacherSpecialization: json["teacher_specialization"],
        teacherExperience: json["teacher_experience"],
        teacherImage: json["teacher_image"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "teacher_name": teacherName,
        "qualification": qualification,
        "teacher_specialization": teacherSpecialization,
        "teacher_experience": teacherExperience,
        "teacher_image": teacherImage,
      };
}