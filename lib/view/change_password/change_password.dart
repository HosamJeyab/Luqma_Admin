import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_const.dart';
import 'package:luqma_admin/core/utils/snackbar_helper.dart';
import 'package:luqma_admin/core/widgets/appbar.dart';
import 'package:luqma_admin/core/widgets/button.dart';
import 'package:luqma_admin/core/widgets/form_field.dart';
import 'package:luqma_admin/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(
          title: "setting_page.change_password".tr(),
          icon: Icons.lock_outline,
        ),
      ),
      body: SafeArea(
        child: Column(
          spacing: AppConst.spacing,
          children: [
            //old password
            formField(
              keyboardType: TextInputType.visiblePassword,
              controller: oldPasswordController,
              hintText: "setting_page.enter_your_old_password".tr(),
              text: "setting_page.old_password".tr(),
              validator: (value) {
                if (value!.isEmpty) {
                  return "setting_page.please_enter_your_old_password".tr();
                }
                return null;
              },
              password: true,
            ),

            //new password
            formField(
              keyboardType: TextInputType.visiblePassword,
              controller: newPasswordController,
              hintText: "setting_page.enter_your_new_password".tr(),
              text: "setting_page.new_password".tr(),
              validator: (value) {
                if (value!.isEmpty) {
                  return "setting_page.please_enter_your_new_password".tr();
                }
                return null;
              },
              password: true,
            ),

            //confirm password
            formField(
              keyboardType: TextInputType.visiblePassword,
              controller: confirmPasswordController,
              hintText: "setting_page.enter_your_confirm_password".tr(),
              text: "setting_page.confirm_password".tr(),
              validator: (value) {
                if (value!.isEmpty) {
                  return "setting_page.please_enter_your_confirm_password".tr();
                }
                return null;
              },
              password: true,
            ),

            //change password button
            Button<AuthProvider>(
              text: "setting_page.change_password".tr(),
              onTap: () async {
                final oldPass = oldPasswordController.text.trim();
                final newPass = newPasswordController.text.trim();
                final confirmPass = confirmPasswordController.text.trim();

                if (newPass != confirmPass) {
                  AppSnackBar.showError(
                    context,
                    "setting_page.new_password_and_confirm_password_do_not_match"
                        .tr(),
                  );
                  return;
                }
                if (newPass.length < 6) {
                  AppSnackBar.showError(
                    context,
                    "setting_page.the_password_should_be_at_least_6_characters"
                        .tr(),
                  );
                  return;
                }

                final success = await context
                    .read<AuthProvider>()
                    .changePassword(oldPass, newPass);

                if (success) {
                  AppSnackBar.showSuccess(
                    context,
                    "setting_page.password_changed_successfully".tr(),
                  );
                  Navigator.pop(context);
                } else {
                  AppSnackBar.showError(
                    context,
                    "setting_page.old_password_is_incorrect".tr(),
                  );
                }
              },
              loadingSelector: (provider) {
                return provider.isLoading;
              },
            ),
          ],
        ),
      ),
    );
  }
}
