import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maha_app/app/data/values/app_strings.dart';
import 'package:flutter_maha_app/app/modules/home/models/user_model.dart';
import 'package:get/get.dart' hide Response;
import '../../../data/networks/base_response.dart';
import '../../../data/networks/network_dio.dart';
import '../../../data/values/app_colors.dart';
import 'user_repository.dart';

class UserServices extends UserRepository {
  Dio get _dio => NetworkDio.createDio(needAuth: true);

  @override
  Future<List<User>?> getData({String? id}) async {
    try {
      Response response = await _dio.get('/api/users?page=$id');
      final resp = BaseResponseApi.fromJson(
        jsonDecode(response.toString()) as Map<String, dynamic>,
      );

      if (resp.data!.isNotEmpty) {
        final listData = (resp.data as List)
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList();

        return listData;
      } else {
        return [];
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        Get.snackbar(
          Labels.error,
          Labels.noInternet,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.warning),
        );
      } else if (e.response != null) {
        Get.snackbar(Labels.error, "Failed to load data");
      } else {
        Get.snackbar(Labels.error, "Unexpected error occurred");
      }
    } catch (e) {
      Get.snackbar(Labels.error, "Unexpected error occurred: $e");
    }
    return null;
  }
}
