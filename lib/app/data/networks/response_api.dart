// To parse this JSON data, do
//
//     final responseAPI = responseAPIFromJson(jsonString);

import 'dart:convert';

ResponseAPi responseAPIFromJson(String str) =>
    ResponseAPi.fromJson(json.decode(str));

String responseAPIToJson(ResponseAPi data) => json.encode(data.toJson());

class ResponseAPi {
  ResponseAPi({
    required this.page,
    required this.perPage,
    required this.totalPages,
    required this.data,
  });

  int page;
  int perPage;
  int totalPages;
  dynamic data;

  factory ResponseAPi.fromJson(Map<String, dynamic> json) => ResponseAPi(
        page: json["page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total_pages": totalPages,
        "data": data,
      };
}
