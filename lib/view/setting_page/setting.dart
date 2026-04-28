import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';
import 'package:luqma_admin/core/widgets/appbar.dart';
import 'package:luqma_admin/provider/auth_provider.dart';
import 'package:luqma_admin/provider/bottom_nav_bar_provider.dart';
import 'package:luqma_admin/view/setting_page/widgets/SettingsItemTile.dart';
import 'package:luqma_admin/view/setting_page/widgets/contact_utils.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(
          title: "setting_page.setting".tr(),
          icon: Icons.settings,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //contact support
            SettingsItemTile(
              title: "setting_page.contact_support".tr(),
              icon: Icons.person,
              onTap: () {
                ContactUtils.showContactOptions(context);
              },
            ),
            //terms and privacy
            SettingsItemTile(
              title: "setting_page.terms_privacy".tr(),
              icon: Icons.privacy_tip_outlined,
              onTap: () {
                Navigator.pushNamed(context, '/terms_privacy');
              },
            ),
            //language
            SettingsItemTile(
              title: "setting_page.language".tr(),
              icon: Icons.language,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder:
                      (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text("العربية"),
                            onTap: () {
                              context.setLocale(const Locale('ar'));
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: const Text("English"),
                            onTap: () {
                              context.setLocale(const Locale('en'));
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                );
              },
            ),
            //auto sign out
            SettingsItemTile(
              title: "setting_page.auto_sign_out".tr(),
              icon: Icons.security,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return AlertDialog(
                          title: Text("setting_page.auto_sign_out".tr()),
                          content: Text(
                            "setting_page.are_you_sure_you_want_enable_auto_sign_out"
                                .tr(),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "setting_page.done".tr(),
                                style: AppTextStyle.subTitle.copyWith(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
                            Switch(
                              value: authProvider.isAutoSignOut,
                              activeColor: AppColor.primaryColor,

                              onChanged: (value) {
                                authProvider.toggleAutoSignOut();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
            //change password
            SettingsItemTile(
              title: "setting_page.change_password".tr(),
              icon: Icons.lock_outline,
              onTap: () {
                Navigator.pushNamed(context, '/change_password');
              },
            ),
            //sign out
            SettingsItemTile(
              title: "setting_page.logout".tr(),
              icon: Icons.logout,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "setting_page.logout".tr(),
                        style: AppTextStyle.appbar,
                      ),
                      content: Text(
                        "setting_page.sure_logout".tr(),
                        style: AppTextStyle.subTitle,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "setting_page.cancel".tr(),
                            style: AppTextStyle.subTitle,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<AuthProvider>().signOut();
                            if (context.mounted) {
                              context.read<BottomNavBarProvider>().reset();

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/signin',
                                (route) => false,
                              );
                            }
                          },
                          child: Text(
                            "setting_page.logout".tr(),
                            style: AppTextStyle.subTitle,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Spacer(),
            //version
            Text(
              "setting_page.version".tr() + "\t" + "1.0.0",
              style: AppTextStyle.subTitle,
            ),
          ],
        ),
      ),
    );
  }
}
