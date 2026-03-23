// To parse this JSON data, do
//
//     final multiApiHomeResponse = multiApiHomeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:avision/data_models/subjectwisevideoVideosAppBarResponse.dart';

class MultiApiTwoHomeResponse {
  String? statusCode;
  String? message;
  NewsAnalysis? newsAnalysis;

  MultiApiTwoHomeResponse({
    this.statusCode,
    this.message,
    this.newsAnalysis,
  });

  factory MultiApiTwoHomeResponse.fromJson(Map<String, dynamic> json) => MultiApiTwoHomeResponse(
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
  List<JobAlertMultiApi>? jobAlert;
  SalesApi? salesApi;
  List<SmallQuizHome>? smallQuizHome;
  RandomFetchQuiz? randamFetchQuiz;
  List<PopularCourseApi>? popularCourseApi;
  List<Video>? youtubeVideo;
  List<Post>? dailyPost;

  NewsAnalysis({
    this.jobAlert,
    this.salesApi,
    this.smallQuizHome,
    this.randamFetchQuiz,
    this.popularCourseApi,
    this.youtubeVideo,
    this.dailyPost,
  });

  factory NewsAnalysis.fromJson(Map<String, dynamic> json) => NewsAnalysis(
    jobAlert: json["job_alert"] == null ? [] : List<JobAlertMultiApi>.from(json["job_alert"]!.map((x) => JobAlertMultiApi.fromJson(x))),
    salesApi: json["sales_api"] == null ? null : SalesApi.fromJson(json["sales_api"]),
    smallQuizHome: json["small_quiz_home"] == null ? [] : List<SmallQuizHome>.from(json["small_quiz_home"]!.map((x) => SmallQuizHome.fromJson(x))),
    randamFetchQuiz: json["randam_fetch_quiz"] == null ? null : RandomFetchQuiz.fromJson(json["randam_fetch_quiz"]),
    popularCourseApi: json["popular_course_api"] == null ? [] : List<PopularCourseApi>.from(json["popular_course_api"]!.map((x) => PopularCourseApi.fromJson(x))),
    youtubeVideo: json["youtube_video"] == null ? [] : List<Video>.from(json["youtube_video"]!.map((x) => Video.fromJson(x))),
    dailyPost: json["daily_post"] == null ? [] : List<Post>.from(json["daily_post"]!.map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "job_alert": jobAlert == null ? [] : List<dynamic>.from(jobAlert!.map((x) => x.toJson())),
    "sales_api": salesApi?.toJson(),
    "small_quiz_home": smallQuizHome == null ? [] : List<dynamic>.from(smallQuizHome!.map((x) => x.toJson())),
    "randam_fetch_quiz": randamFetchQuiz?.toJson(),
    "popular_course_api": popularCourseApi == null ? [] : List<dynamic>.from(popularCourseApi!.map((x) => x.toJson())),
    "youtube_video": youtubeVideo == null ? [] :  List<dynamic>.from(youtubeVideo!.map((x) => x.toJson())),
    "daily_post": dailyPost == null ? [] : List<dynamic>.from(dailyPost!.map((x) => x.toJson())),
  };
}

class Post {
  String? postId;
  String? userName;
  String? profileImg;
  String? userRole;
  String? postTitle;
  String? postImage;
  DateTime? postDate;
  String? postCategory;
  dynamic postType;
  dynamic likeCount;
  dynamic commentCount;
  dynamic postLikeStatus;
  String? postUrl;
  List<CategoryDetailsArray>? categoryDetailsArray;
  List<FeedPostQuiz>? quizArray;

  Post({
    this.postId,
    this.userName,
    this.profileImg,
    this.userRole,
    this.postTitle,
    this.postImage,
    this.postDate,
    this.postCategory,
    this.postType,
    this.likeCount,
    this.commentCount,
    this.postLikeStatus,
    this.postUrl,
    this.categoryDetailsArray,
    this.quizArray,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    postId: json["post_id"],
    userName: json["user_name"],
    profileImg: json["profile_img"],
    userRole: json["user_role"],
    postTitle: json["post_title"],
    postImage: json["post_image"],
    postDate: json["post_date"] == null ? null : DateTime.parse(json["post_date"]),
    postCategory: json["post_category"],
    postType: json["post_type"],
    likeCount: json["like_count"],
    commentCount: json["comment_count"],
    postLikeStatus: json["post_like_status"],
    postUrl: json["post_url"],
    categoryDetailsArray: json["category_details_array"] == null ? [] : List<CategoryDetailsArray>.from(json["category_details_array"]!.map((x) => CategoryDetailsArray.fromJson(x))),
    quizArray: json["quiz_array"] == null ? [] : List<FeedPostQuiz>.from(json["quiz_array"]!.map((x) => FeedPostQuiz.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "post_id": postId,
    "user_name": userName,
    "profile_img": profileImg,
    "user_role": userRole,
    "post_title": postTitle,
    "post_image": postImage,
    "post_date": postDate?.toIso8601String(),
    "post_category": postCategory,
    "post_type": postType,
    "like_count": likeCount,
    "comment_count": commentCount,
    "post_like_status": postLikeStatus,
    "post_url": postUrl,
    "category_details_array": categoryDetailsArray == null ? [] : List<dynamic>.from(categoryDetailsArray!.map((x) => x.toJson())),
    "quiz_array": quizArray == null ? [] : List<dynamic>.from(quizArray!.map((x) => x.toJson())),
  };
}

class CategoryDetailsArray {
  String? postContentDetails;

  CategoryDetailsArray({
    this.postContentDetails,
  });

  factory CategoryDetailsArray.fromJson(Map<String, dynamic> json) => CategoryDetailsArray(
    postContentDetails: json["post_content_details"],
  );

  Map<String, dynamic> toJson() => {
    "post_content_details": postContentDetails,
  };
}

class FeedPostQuiz {
  String? quizId;
  String? quizName;
  String? totQus;
  String? totTime;
  List<dynamic>? takenList;

  FeedPostQuiz({
    this.quizId,
    this.quizName,
    this.totQus,
    this.totTime,
    this.takenList,
  });

  factory FeedPostQuiz.fromJson(Map<String, dynamic> json) => FeedPostQuiz(
    quizId: json["quiz_id"],
    quizName: json["quiz_name"],
    totQus: json["tot_qus"],
    totTime: json["tot_time"],
    takenList: json["taken_list"] == null ? [] : List<dynamic>.from(json["taken_list"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "quiz_id": quizId,
    "quiz_name": quizName,
    "tot_qus": totQus,
    "tot_time": totTime,
    "taken_list": takenList == null ? [] : List<dynamic>.from(takenList!.map((x) => x)),
  };
}
class JobAlertMultiApi {
  String? jobId;
  String? jobTitle;
  String? jobImg;
  String? link;

  JobAlertMultiApi({
    this.jobId,
    this.jobTitle,
    this.jobImg,
    this.link,
  });

  factory JobAlertMultiApi.fromJson(Map<String, dynamic> json) => JobAlertMultiApi(
    jobId: json["job_id"],
    jobTitle: json["job_title"],
    jobImg: json["job_img"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "job_id": jobId,
    "job_title": jobTitle,
    "job_img": jobImg,
    "link": link,
  };
}

class PopularCourseApi {
  String? productId;
  String? productName;
  String? productPrice;
  String? productOfferPrice;
  String? productImage;
  String? productType;
  String? courseDuration;

  PopularCourseApi({
    this.productId,
    this.productName,
    this.productPrice,
    this.productOfferPrice,
    this.productImage,
    this.productType,
    this.courseDuration,
  });

  factory PopularCourseApi.fromJson(Map<String, dynamic> json) => PopularCourseApi(
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

class RandomFetchQuiz {
  DateTime? fromDates;
  DateTime? toDates;
  List<DailyDoseQuiz>? quizArr;

  RandomFetchQuiz({
    this.fromDates,
    this.toDates,
    this.quizArr,
  });

  factory RandomFetchQuiz.fromJson(Map<String, dynamic> json) => RandomFetchQuiz(
    fromDates: json["from-dates"] == null ? null : DateTime.parse(json["from-dates"]),
    toDates: json["to-dates"] == null ? null : DateTime.parse(json["to-dates"]),
    quizArr: json["quiz_arr"] == null ? [] : List<DailyDoseQuiz>.from(json["quiz_arr"]!.map((x) => DailyDoseQuiz.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "from-dates": "${fromDates!.year.toString().padLeft(4, '0')}-${fromDates!.month.toString().padLeft(2, '0')}-${fromDates!.day.toString().padLeft(2, '0')}",
    "to-dates": "${toDates!.year.toString().padLeft(4, '0')}-${toDates!.month.toString().padLeft(2, '0')}-${toDates!.day.toString().padLeft(2, '0')}",
    "quiz_arr": quizArr == null ? [] : List<dynamic>.from(quizArr!.map((x) => x.toJson())),
  };
}

class DailyDoseQuiz {
  String? quizId;
  String? quizBase;
  String? quizName;
  String? typeId;
  String? courseId;
  String? chapterId;
  String? childTypeId;
  int? status;
  int? totalTime;
  int? totalMarks;
  String? totalQuestion;
  DateTime? createdDate;

  DailyDoseQuiz({
    this.quizId,
    this.quizBase,
    this.quizName,
    this.typeId,
    this.courseId,
    this.chapterId,
    this.childTypeId,
    this.status,
    this.totalTime,
    this.totalMarks,
    this.totalQuestion,
    this.createdDate,
  });

  factory DailyDoseQuiz.fromJson(Map<String, dynamic> json) => DailyDoseQuiz(
    quizId: json["quiz_id"],
    quizBase: json["quiz_base"],
    quizName: json["quiz_name"],
    typeId: json["type_id"],
    courseId: json["course_id"],
    chapterId: json["chapter_id"],
    childTypeId: json["child_type_id"],
    status: json["status"],
    totalTime: json["total_time"],
    totalMarks: json["total_marks"],
    totalQuestion: json["total_question"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
  );

  Map<String, dynamic> toJson() => {
    "quiz_id": quizId,
    "quiz_base": quizBase,
    "quiz_name": quizName,
    "type_id": typeId,
    "course_id": courseId,
    "chapter_id": chapterId,
    "child_type_id": childTypeId,
    "status": status,
    "total_time": totalTime,
    "total_marks": totalMarks,
    "total_question": totalQuestion,
    "created_date": "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
  };
}

class SalesApi {
  String? title1;
  String? title2;
  String? whatsapp;
  String? call;
  String? image;

  SalesApi({
    this.title1,
    this.title2,
    this.whatsapp,
    this.call,
    this.image,
  });

  factory SalesApi.fromJson(Map<String, dynamic> json) => SalesApi(
    title1: json["title1"],
    title2: json["title2"],
    whatsapp: json["whatsapp"],
    call: json["call"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title1": title1,
    "title2": title2,
    "whatsapp": whatsapp,
    "call": call,
    "image": image,
  };
}

class SmallQuizHome {
  String? quizId;
  String? quizBase;
  String? quizName;
  String? typeId;
  String? courseId;
  String? chapterId;
  String? totQus;
  String? userId;
  String? childTypeId;
  DateTime? createdDate;
  DateTime? modifiedDate;

  SmallQuizHome({
    this.quizId,
    this.quizBase,
    this.quizName,
    this.typeId,
    this.courseId,
    this.chapterId,
    this.totQus,
    this.userId,
    this.childTypeId,
    this.createdDate,
    this.modifiedDate,
  });

  factory SmallQuizHome.fromJson(Map<String, dynamic> json) => SmallQuizHome(
    quizId: json["quiz_id"],
    quizBase: json["quiz_base"],
    quizName: json["quiz_name"],
    typeId: json["type_id"],
    courseId: json["course_id"],
    chapterId: json["chapter_id"],
    totQus: json["tot_qus"],
    userId: json["user_id"],
    childTypeId: json["child_type_id"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    modifiedDate: json["modified_date"] == null ? null : DateTime.parse(json["modified_date"]),
  );

  Map<String, dynamic> toJson() => {
    "quiz_id": quizId,
    "quiz_base": quizBase,
    "quiz_name": quizName,
    "type_id": typeId,
    "course_id": courseId,
    "chapter_id": chapterId,
    "tot_qus": totQus,
    "user_id": userId,
    "child_type_id": childTypeId,
    "created_date": "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
    "modified_date": modifiedDate?.toIso8601String(),
  };
}
