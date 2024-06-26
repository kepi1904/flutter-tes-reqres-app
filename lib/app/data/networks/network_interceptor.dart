import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;

import '../../routes/app_pages.dart';
import '../storages/storage.dart';

class NetworkInterceptor extends Interceptor {
  Dio refreshDio = Dio();
  bool needAuth;
  Dio previous;

  NetworkInterceptor(this.previous, {this.needAuth = false});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
    }
    var accessToken = storage.read(StorageName.token);

    if (needAuth) {
      log('access Token: $accessToken');
      options.headers["Authorization"] = "Bearer $accessToken";
    } else {
      options.headers["Authorization"] = accessToken;
    }
    options.headers["Accept"] = "application/json";

    if (options.data != null) {
      if (options.data is! FormData) {
        options.headers["Content-Type"] = "application/json";
      }
    } else {
      options.headers["Content-Type"] = "application/json";
    }
    if (kDebugMode) {
      print('OPTIONS $options');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    return super.onError(err, handler);
  }
}
