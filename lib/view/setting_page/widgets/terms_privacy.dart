import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';

class TermsPrivacy extends StatelessWidget {
  const TermsPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Text("setting_page.terms_privacy".tr(), style: AppTextStyle.appbar),
            Text(
              DateFormat(
                'EEEE,  MMM d',
                context.locale.toString(),
              ).format(DateTime.now()),
              style: AppTextStyle.subAppbar,
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: AppColor.primaryColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.privacy_tip_outlined,
              color: AppColor.primaryColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "setting_page.terms_of_use".tr(),
                  style: AppTextStyle.appbar,
                ),
                Text(
                  //                   '''This application is intended for internal administrative use to manage orders and menu items for the store.

                  // Access to this application should only be granted to authorized personnel.

                  // The application must not be used for purposes unrelated to managing orders or updating menu items.

                  // The store administration reserves the right to modify or update the application's content or features at any time when necessary.''',
                  "setting_page.terms_content".tr(),
                  style: AppTextStyle.subAppbar.copyWith(
                    color: AppColor.primaryTextColor,
                  ),
                ),
                Divider(),
                Text("setting_page.privacy".tr(), style: AppTextStyle.appbar),
                Text(
                  //                   '''The application may store certain data required for system operation, such as:

                  // * Menu item information

                  // * Order details

                  // * Administrative account data related to using the system

                  // This data is used solely for operating the system and managing orders within the store.

                  // No data is shared with external third parties.''',
                  "setting_page.privacy_content".tr(),
                  style: AppTextStyle.subAppbar.copyWith(
                    color: AppColor.primaryTextColor,
                  ),
                ),
                Divider(),
                Text(
                  "setting_page.responsibility".tr(),
                  style: AppTextStyle.appbar,
                ),
                Text(
                  // '''Users are responsible for using the application properly and for maintaining the confidentiality of their login credentials.''',
                  "setting_page.responsibility_content".tr(),
                  style: AppTextStyle.subAppbar.copyWith(
                    color: AppColor.primaryTextColor,
                  ),
                ),
                Divider(),
                Text("setting_page.support".tr(), style: AppTextStyle.appbar),
                Text(
                  // '''If you encounter any issues or have questions, you can contact support through the Contact Support option within the application.''',
                  "setting_page.support_content".tr(),
                  style: AppTextStyle.subAppbar.copyWith(
                    color: AppColor.primaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
