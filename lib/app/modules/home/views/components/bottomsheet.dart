// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';

import '../../../../data/values/app_sizes.dart';

showBottomSheetProfile(BuildContext context, Widget listWidget) =>
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.p20))),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: Sizes.p16,
            right: Sizes.p16,
            left: Sizes.p16,
          ),
          child: SingleChildScrollView(child: listWidget),
        );
      },
    );
