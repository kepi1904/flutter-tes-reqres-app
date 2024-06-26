import 'package:flutter/material.dart';
import 'package:flutter_maha_app/app/data/values/app_colors.dart';
import 'package:flutter_maha_app/app/data/values/app_strings.dart';
import 'package:get/get.dart';
import 'package:flutter_maha_app/app/modules/home/controllers/create_user_controller.dart';

import '../../../../data/values/app_sizes.dart';

class CreateUserBottomSheet extends StatelessWidget {
  final CreateUserController controller = Get.put(CreateUserController());

  CreateUserBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              Labels.addUser,
              style:
                  TextStyle(fontSize: Sizes.p18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Sizes.p20),
            TextField(
              decoration: const InputDecoration(
                labelText: Labels.name,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.name.value = value,
            ),
            const SizedBox(height: Sizes.p10),
            TextField(
              decoration: const InputDecoration(
                labelText: Labels.job,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.job.value = value,
            ),
            const SizedBox(height: Sizes.p20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.green),
              onPressed: () {
                Get.snackbar("Please wait...", "");
                controller.createUserData();
                Navigator.pop(context);
              },
              child: const Text(Labels.addUser),
            ),
          ],
        ),
      ),
    );
  }
}
