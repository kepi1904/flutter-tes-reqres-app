import 'package:flutter/material.dart';
import 'package:flutter_maha_app/app/data/values/app_colors.dart';
import 'package:flutter_maha_app/app/data/values/app_strings.dart';
import 'package:flutter_maha_app/app/modules/home/models/user_model.dart';
import 'package:flutter_maha_app/app/modules/home/repository/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  bool loading = true;
  int page = 0;
  ScrollController scrollController = ScrollController();
  double previousScrollPosition = 0.0;
  bool hasShownSnackbar = false; // Flag to track if snackbar is shown

  final count = 0.obs;
  RxList<User> datalist = <User>[].obs;
  final UserRepository dataRepo = UserServices();

  @override
  void onInit() {
    update();
    scrollController.addListener(_scrollListener);
    loadUsersFromPrefs();
    findAllUser();
    super.onInit();
  }

  void _scrollListener() {
    var triggerLoadMore = 0.9 * scrollController.position.maxScrollExtent;
    if (scrollController.position.pixels > triggerLoadMore) {
      if (scrollController.position.pixels > previousScrollPosition) {
        findAllUser();
      }
    }
    previousScrollPosition = scrollController.position.pixels;
  }

  @override
  void onReady() {
    update();
    super.onReady();
  }

  @override
  void onClose() {
    update();
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> refreshData() async {
    page = 0;
    datalist.clear();
    await findAllUser();
  }

  findAllUser() {
    findAll(++page).then((value) {
      if (value.isEmpty && !hasShownSnackbar) {
        Get.snackbar(
          Labels.perhatian,
          ' ${Labels.tidakAdaData}',
          backgroundColor: AppColors.orange,
          colorText: AppColors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.warning),
        );
        hasShownSnackbar = true; // Set the flag to true when snackbar is shown
      } else if (value.isNotEmpty) {
        datalist.addAll(value);
        saveUsersToPrefs();
        hasShownSnackbar = false; // Reset the flag when new data is loaded
      }
      loading = false;
      update();
    }).catchError((err) {
      loading = false;
    });
  }

  Future<List<User>> findAll(int page) async {
    final res = await dataRepo.getData(id: page.toString());
    try {
      if (res!.isNotEmpty) {
        return res;
      }
    } catch (e) {
      update();
    }
    return [];
  }

  Future<void> saveUsersToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> userStrings =
        datalist.map((user) => user.toJson()).toList();
    await prefs.setStringList('user_list', userStrings.cast<String>());
  }

  Future<void> loadUsersFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? userStrings = prefs.getStringList('user_list');
    if (userStrings != null) {
      datalist.value = userStrings
          .map(
              (userString) => User.fromJson(userString as Map<String, dynamic>))
          .toList();
      update();
    }
  }
}
