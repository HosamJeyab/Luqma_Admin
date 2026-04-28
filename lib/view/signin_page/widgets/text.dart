import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';

class textPage extends StatelessWidget {
  const textPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("signin.welcome".tr(), style: AppTextStyle.title),
        Text(
          "signin.sign_in_to_access_the_secure_dashboard".tr(),
          style: AppTextStyle.subTitle,
        ),
      ],
    );
  }
}
