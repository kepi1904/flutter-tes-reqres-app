class BaseResponseApi {
  BaseResponseApi(
      {this.perPage, this.totalPages, required this.data, this.page});

  factory BaseResponseApi.fromJson(Map<String, dynamic> json) =>
      BaseResponseApi(
        perPage: json['per_page'] as int?,
        totalPages: json['total_pages'] as int?,
        page: json['page'] as int?,
        data: json['data'] as List<dynamic>?,
      );

  int? perPage;

  int? totalPages;
  int? page;
  List<dynamic>? data;

  Map<String, dynamic> toJson() => {
        'per_page': perPage,
        'total_pages': totalPages,
        'page': page,
        'data': data,
      };
}
