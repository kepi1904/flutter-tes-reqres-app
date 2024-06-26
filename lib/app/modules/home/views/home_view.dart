import 'package:flutter/material.dart';
import 'package:flutter_maha_app/app/data/values/app_colors.dart';
import 'package:flutter_maha_app/app/data/values/app_strings.dart';
import 'package:flutter_maha_app/app/modules/home/views/components/body_view.dart';
import 'package:flutter_maha_app/app/modules/home/views/components/bottomsheet.dart';
import 'package:flutter_maha_app/app/modules/home/views/components/create_user_form.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(Labels.profileView),
        backgroundColor: AppColors.green,
        centerTitle: true,
      ),
      body: Obx(() => getBody(controller)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.green,
        onPressed: () {
          showBottomSheetProfile(context, CreateUserBottomSheet());
        },
        tooltip: Labels.addUser,
        child: const Icon(Icons.add),
      ),
    );
  }
}
