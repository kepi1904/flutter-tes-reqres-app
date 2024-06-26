import 'package:flutter/material.dart';
import 'package:flutter_maha_app/app/data/values/app_colors.dart';
import 'package:flutter_maha_app/app/data/values/app_sizes.dart';
import 'package:flutter_maha_app/app/modules/home/views/components/bottomsheet.dart';
import 'package:flutter_maha_app/app/modules/home/views/components/view_profile.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../data/values/app_strings.dart';
import '../../controllers/home_controller.dart';

Widget getBody(HomeController controller) {
  return Stack(
    children: [
      RefreshIndicator(
        onRefresh: controller.refreshData,
        child: controller.datalist.isEmpty
            ? controller.loading
                ? Center(
                    child: SizedBox(
                      width: Sizes.p100,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.refreshData();
                          },
                          child: const Row(
                            children: [
                              gapW8,
                              Icon(
                                Icons.refresh,
                                size: Sizes.p50,
                              )
                            ],
                          )),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(Labels.noData),
                        gapH10,
                        SizedBox(
                          width: Sizes.p100,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.refreshData();
                              },
                              child: const Row(
                                children: [
                                  gapW8,
                                  Icon(
                                    Icons.refresh,
                                    size: Sizes.p50,
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  )
            : ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.datalist.length,
                itemBuilder: (context, index) {
                  var user = controller.datalist[index];
                  return Container(
                    padding: const EdgeInsets.all(Sizes.p2),
                    height: Sizes.p150,
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          showBottomSheetProfile(
                              context, UserDetailPage(userInfo: user));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(Sizes.p5),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: user.avatar.toString(),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.account_box_rounded,
                                          size: 20,
                                          color: Colors.green,
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.only(right: Sizes.p5),
                                        ),
                                        Text(
                                          '${user.firstName} ${user.lastName}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Sizes.p20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.email,
                                          size: Sizes.p20,
                                          color: AppColors.green,
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.only(right: Sizes.p5),
                                        ),
                                        Text(user.email.toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    ],
  );
}
