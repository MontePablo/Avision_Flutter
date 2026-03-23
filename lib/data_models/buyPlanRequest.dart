import 'package:flutter/cupertino.dart';

class BuyPlanRequest {
  String studentId;
  String productId;
  String productType;

  BuyPlanRequest({
    required this.studentId,
    required this.productId,
    required this.productType,
  });

  factory BuyPlanRequest.fromJson(Map<String, dynamic> json) => BuyPlanRequest(
    studentId: json["student_id"],
    productId: json["product_id"],
    productType: json["product_type"],
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "product_id": productId,
    "product_type": productType,
  };
}