class JobAlertsHomeResponse {
  String? statusCode;
  String? message;
  List<JobAlert>? jobAlert;

  JobAlertsHomeResponse({
    this.statusCode,
    this.message,
    this.jobAlert,
  });

  factory JobAlertsHomeResponse.fromJson(Map<String, dynamic> json) => JobAlertsHomeResponse(
    statusCode: json["status_code"],
    message: json["message"],
    jobAlert: json["job_alert"] == null ? [] : List<JobAlert>.from(json["job_alert"]!.map((x) => JobAlert.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "job_alert": jobAlert == null ? [] : List<dynamic>.from(jobAlert!.map((x) => x.toJson())),
  };
}

class JobAlert {
  String? jobId;
  String? jobTitle;
  String? jobImg;
  String? link;

  JobAlert({
    this.jobId,
    this.jobTitle,
    this.jobImg,
    this.link,
  });

  factory JobAlert.fromJson(Map<String, dynamic> json) => JobAlert(
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
