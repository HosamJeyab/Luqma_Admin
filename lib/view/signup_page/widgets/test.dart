import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';

class textPage extends StatelessWidget {
  const textPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('signup.welcome'.tr(), style: AppTextStyle.title),
        Text(
          'signup.register_to_create_your_own_store'.tr(),
          style: AppTextStyle.subTitle,
        ),
      ],
    );
  }
}
