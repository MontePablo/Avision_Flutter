
class LoginResponse {
  String? statusCode;
  String? message;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userId;
  String? userImg;
  String? appId;
  String? userRole;
  String? studentArea;
  int? centerId;

  LoginResponse({
    this.statusCode,
    this.message,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userId,
    this.userImg,
    this.appId,
    this.userRole,
    this.studentArea,
    this.centerId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    statusCode: json["status_code"],
    message: json["message"],
    userName: json["user_name"],
    userEmail: json["user_email"],
    userPhone: json["user_phone"],
    userId: json["user_id"],
    userImg: json["user_img"],
    appId: json["app_id"],
    userRole: json["user_role"],
    studentArea: json["student_area"],
    centerId: json["center_id"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "user_name": userName,
    "user_email": userEmail,
    "user_phone": userPhone,
    "user_id": userId,
    "user_img": userImg,
    "app_id": appId,
    "user_role": userRole,
    "student_area": studentArea,
    "center_id": centerId,
  };
}
