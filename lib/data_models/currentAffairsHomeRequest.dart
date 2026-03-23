class CurrentAffairsHomeRequest {
  String? pageIndex;

  CurrentAffairsHomeRequest({
    this.pageIndex,
  });

  factory CurrentAffairsHomeRequest.fromJson(Map<String, dynamic> json) => CurrentAffairsHomeRequest(
    pageIndex: json["page_index"],
  );

  Map<String, dynamic> toJson() => {
    "page_index": pageIndex,
  };
}
