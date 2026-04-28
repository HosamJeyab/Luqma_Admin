import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_const.dart';
import 'package:luqma_admin/core/utils/handle_back.dart';
import 'package:luqma_admin/core/utils/snackbar_helper.dart';
import 'package:luqma_admin/core/widgets/button.dart';
import 'package:luqma_admin/core/widgets/form_field.dart';
import 'package:luqma_admin/core/widgets/logo.dart';
import 'package:luqma_admin/provider/auth_provider.dart';
import 'package:luqma_admin/view/signup_page/widgets/test.dart';

import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return WillPopScope(
      onWillPop: () => HandleBack.handelBack(context),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            //language
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<String>(
                  icon: Icon(Icons.language),
                  underline: Container(),
                  iconDisabledColor: AppColor.primaryColor,
                  iconEnabledColor: AppColor.primaryColor,
                  value: context.locale.languageCode,
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text(' English ')),
                    DropdownMenuItem(value: 'ar', child: Text('  العربية')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      context.setLocale(Locale(value));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppConst.padding),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    logo(),
                    const SizedBox(height: 20),
                    textPage(),
                    const SizedBox(height: 30),

                    formField(
                      keyboardType: TextInputType.text,
                      password: false,
                      text: 'signup.user_name'.tr(),
                      hintText: 'signup.your_name'.tr(),
                      controller: authProvider.usernamecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'signup.please_enter_your_username'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    formField(
                      keyboardType: TextInputType.emailAddress,
                      password: false,
                      text: 'signup.email'.tr(),
                      hintText: 'name@example.com',
                      controller: authProvider.emailcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'signup.please_enter_your_email'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    formField(
                      keyboardType: TextInputType.visiblePassword,
                      password: true,
                      text: 'signup.password'.tr(),
                      hintText: 'signup.enter_your_password'.tr(),
                      controller: authProvider.passwordcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'signup.please_enter_your_password'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    formField(
                      keyboardType: TextInputType.visiblePassword,
                      password: true,
                      text: 'signup.confirm_password'.tr(),
                      hintText: 'signup.re_enter_your_password'.tr(),
                      controller: authProvider.confirmPasswordcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'signup.please_enter_your_password'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    Button<AuthProvider>(
                      loadingSelector: (provider) => provider.isLoading,
                      onTap:
                          authProvider.isLoading
                              ? null
                              : () async {
                                if (authProvider
                                        .emailcontroller
                                        .text
                                        .isNotEmpty &&
                                    authProvider
                                        .passwordcontroller
                                        .text
                                        .isNotEmpty &&
                                    authProvider
                                        .confirmPasswordcontroller
                                        .text
                                        .isNotEmpty &&
                                    authProvider
                                        .usernamecontroller
                                        .text
                                        .isNotEmpty) {
                                  bool success = await authProvider
                                      .registerUser(
                                        authProvider.usernamecontroller.text,
                                        authProvider.emailcontroller.text,
                                        authProvider.passwordcontroller.text,
                                      );
                                  if (success) {
                                    AppSnackBar.showSuccess(
                                      context,
                                      "signup.Success! Account Created".tr(),
                                    );
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/signin',
                                    );
                                  } else {
                                    AppSnackBar.showError(
                                      context,
                                      "signup.Failed to create account".tr(),
                                    );
                                  }
                                }
                              },
                      text:
                          authProvider.isLoading
                              ? "signup.Loading...".tr()
                              : "signup.Register".tr(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
