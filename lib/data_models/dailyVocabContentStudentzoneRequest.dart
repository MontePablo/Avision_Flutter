import 'package:flutter/cupertino.dart';
class DailyVocabContentStudentzoneRequest {
  String postId;

  DailyVocabContentStudentzoneRequest({
    required this.postId,
  });

  factory DailyVocabContentStudentzoneRequest.fromJson(Map<String, dynamic> json) => DailyVocabContentStudentzoneRequest(
    postId: json["post_id"],
  );

  Map<String, dynamic> toJson() => {
    "post_id": postId,
  };
}
