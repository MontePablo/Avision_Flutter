class PostsFeedRequest {
  String? pageIndex;

  PostsFeedRequest({
    required this.pageIndex,
  });

  factory PostsFeedRequest.fromJson(Map<String, dynamic> json) => PostsFeedRequest(
    pageIndex: json["page_index"],
  );

  Map<String, dynamic> toJson() => {
    "page_index": pageIndex,
  };
}
