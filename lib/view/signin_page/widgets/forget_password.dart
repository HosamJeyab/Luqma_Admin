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

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final TextEditingController emailController = TextEditingController();
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
          title: "signin.forget_password".tr(),
          icon: Icons.lock_outline,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppConst.padding),
          child: Column(
            spacing: AppConst.spacing,
            children: [
              //text field for email
              formField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                hintText: "signin.email".tr(),
                text: "signin.email".tr(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "signin.please_enter_your_email".tr();
                  }
                  return null;
                },
                password: false,
              ),
              //send reset email button
              Button<AuthProvider>(
                text: "signin.send_reset_email".tr(),
                onTap: () async {
                  final email = emailController.text.trim();

                  if (email.isEmpty) {
                    AppSnackBar.showError(
                      context,
                      "signin.please_enter_your_email".tr(),
                    );
                    return;
                  }

                  try {
                    await context.read<AuthProvider>().forgetPassword(email);

                    if (context.mounted) {
                      AppSnackBar.showSuccess(
                        context,
                        "signin.password_reset_email_sent_check_your_inbox"
                            .tr(),
                      );
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      AppSnackBar.showError(
                        context,
                        "signin.error".tr() + "${e.toString()}",
                      );
                    }
                  }
                },
                loadingSelector: (provider) => provider.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
