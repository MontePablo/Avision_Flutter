import 'package:flutter/cupertino.dart';
class LoginRequest {
  String userEmail;
  String userPassword;

  LoginRequest({
    required this.userEmail,
    required this.userPassword,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    userEmail: json["user_email"],
    userPassword: json["user_password"],
  );

  Map<String, dynamic> toJson() => {
    "user_email": userEmail,
    "user_password": userPassword,
  };
}
