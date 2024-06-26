import 'package:flutter/material.dart';
import 'package:flutter_maha_app/app/data/values/app_sizes.dart';
import 'package:flutter_maha_app/app/data/values/app_strings.dart';
import 'package:flutter_maha_app/app/modules/home/models/add_user.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class CreateUserController extends GetxController {
  RxString name = ''.obs;
  RxString job = ''.obs;
  RxString id = ''.obs;
  Rx<DateTime> createdAt = DateTime.now().obs;

  final Dio dio = Dio();

  void createUserData() async {
    try {
      final response = await dio.post(
        '${Labels.baseUrl}/api/users',
        data: {
          "name": name.value,
          "job": job.value,
        },
      );

      if (response.statusCode == 201) {
        final userData = AddUserModel.fromJson(response.data);
        id.value = userData.id;
        createdAt.value = userData.createdAt;
        Get.back(result: true); // Close bottom sheet with success
        showSuccessDialog(userData); // Show success dialog
      } else {
        Get.snackbar(Labels.error, Labels.failedCreate);
      }
    } catch (e) {
      Get.snackbar(Labels.error, Labels.failedCreate);
    }
  }

  void showSuccessDialog(AddUserModel userData) {
    Get.dialog(
      AlertDialog(
        title: const Text(Labels.success),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${Labels.name}: ${userData.name}'),
            gapH8,
            Text('${Labels.job}: ${userData.job}'),
            gapH8,
            Text('${Labels.id}: ${userData.id}'),
            gapH8,
            Text('${Labels.createAt}: ${userData.createdAt}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(Labels.ok),
          ),
        ],
      ),
    );
  }
}
