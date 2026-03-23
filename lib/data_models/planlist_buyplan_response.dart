class PlanlistBuyplanResponse {
  String? statusCode;
  String? message;
  List<Plans>? notificationList;

  PlanlistBuyplanResponse({
    this.statusCode,
    this.message,
    this.notificationList,
  });

  factory PlanlistBuyplanResponse.fromJson(Map<String, dynamic> json) => PlanlistBuyplanResponse(
    statusCode: json["status_code"],
    message: json["message"],
    notificationList: json["notification_list"] == null ? [] : List<Plans>.from(json["notification_list"]!.map((x) => Plans.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "notification_list": notificationList == null ? [] : List<dynamic>.from(notificationList!.map((x) => x.toJson())),
  };
}

class Plans {
  String? planId;
  String? planName;
  String? price;
  String? offerPrice;
  String? duration;
  DateTime? createdDate;
  DateTime? modifiedDate;
  String? cuponId;
  String? cuponCode;

  Plans({
    this.planId,
    this.planName,
    this.price,
    this.offerPrice,
    this.duration,
    this.createdDate,
    this.modifiedDate,
    this.cuponId,
    this.cuponCode,
  });

  factory Plans.fromJson(Map<String, dynamic> json) => Plans(
    planId: json["plan_id"],
    planName: json["plan_name"],
    price: json["price"],
    offerPrice: json["offer_price"],
    duration: json["duration"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    modifiedDate: json["modified_date"] == null ? null : DateTime.parse(json["modified_date"]),
    cuponId: json["cupon_id"],
    cuponCode: json["cupon_code"],
  );

  Map<String, dynamic> toJson() => {
    "plan_id": planId,
    "plan_name": planName,
    "price": price,
    "offer_price": offerPrice,
    "duration": duration,
    "created_date": "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
    "modified_date": modifiedDate?.toIso8601String(),
    "cupon_id": cuponId,
    "cupon_code": cuponCode,
  };
}
