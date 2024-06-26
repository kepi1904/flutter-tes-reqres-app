import 'package:flutter/material.dart';
import 'package:flutter_maha_app/app/data/values/app_colors.dart';
import 'package:flutter_maha_app/app/data/values/app_sizes.dart';

import '../../models/user_model.dart';

class UserDetailPage extends StatelessWidget {
  UserDetailPage({Key? key, required this.userInfo}) : super(key: key);

  late User userInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          width: Sizes.p40,
          child: Divider(
            height: Sizes.p10,
            color: AppColors.black,
          ),
        ),
        gapH40,
        Container(
          width: Sizes.p200,
          height: Sizes.p200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(userInfo.avatar.toString()),
            ),
          ),
        ),
        gapH10,
        Text(
          "${userInfo.firstName} ${userInfo.lastName}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.p30,
          ),
        ),
        gapH10,
        Text(
          userInfo.email.toString(),
          style: const TextStyle(
            color: AppColors.blue,
            fontSize: Sizes.p18,
          ),
        ),
        gapH40
      ],
    );
  }
}
