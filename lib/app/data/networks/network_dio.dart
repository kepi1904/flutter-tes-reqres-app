import 'package:dio/dio.dart';
import 'package:flutter_maha_app/app/data/values/app_strings.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'network_interceptor.dart';

class NetworkDio {
  static Dio createDio({
    required bool needAuth,
  }) {
    const String url = Labels.baseUrl;

    final options = BaseOptions(
        baseUrl: url, connectTimeout: 60 * 2000, receiveTimeout: 60 * 2000);

    Dio dio = Dio(options);
    dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
      NetworkInterceptor(dio, needAuth: needAuth)
    ]);

    return dio;
  }
}
