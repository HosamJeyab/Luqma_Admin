import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_const.dart';
import 'package:luqma_admin/core/utils/handle_back.dart';
import 'package:luqma_admin/core/utils/snackbar_helper.dart';
import 'package:luqma_admin/core/widgets/button.dart';
import 'package:luqma_admin/core/widgets/form_field.dart';
import 'package:luqma_admin/core/widgets/logo.dart';
import 'package:luqma_admin/core/widgets/text_button.dart';
import 'package:luqma_admin/provider/auth_provider.dart';
import 'package:luqma_admin/view/signin_page/widgets/text.dart';
import 'package:provider/provider.dart';
// import 'package:luqma_admin/core/const/app_text_style.dart';
// import 'package:luqma_admin/view/signin_page/widgets/google_button.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    return WillPopScope(
      onWillPop: () => HandleBack.handelBack(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  spacing: AppConst.spacing,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //logo
                    logo(),
                    //text page
                    textPage(),
                    //email form field
                    formField(
                      password: false,
                      text: "signin.email".tr(),
                      hintText: "name@example.com",
                      controller: authProvider.emailcontrollersignin,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "signin.please_enter_your_email".tr();
                        } else if (!value.contains('@') ||
                            !value.contains('.') ||
                            value.length < 5) {
                          return "signin.please_enter_a_valid_email".tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    //password form field
                    formField(
                      password: true,
                      text: "signin.password".tr(),
                      hintText: "signin.password".tr(),
                      controller: authProvider.passwordcontrollersigin,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "signin.please_enter_your_password".tr();
                        } else if (value.length < 6) {
                          return "signin.password_must_be_at_least_6_characters"
                              .tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    //forget password
                    textButton(
                      onTap: () {
                        Navigator.pushNamed(context, '/forget_password');
                      },
                      text: "signin.forget_password?".tr(),
                    ),
                    //sign in button
                    Button<AuthProvider>(
                      text: "signin.sign_in".tr(),
                      loadingSelector: (provider) => provider.isLoading,
                      onTap: () async {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult.contains(
                          ConnectivityResult.none,
                        )) {
                          if (context.mounted) {
                            AppSnackBar.showError(
                              context,
                              "No Internet Connection",
                            );
                          }
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          bool success = await authProvider.signIn(
                            authProvider.emailcontrollersignin.text,
                            authProvider.passwordcontrollersigin.text,
                          );
                          if (success) {
                            if (await authProvider.getUserRole() == true) {
                              Navigator.pushReplacementNamed(
                                context,
                                '/bottomnavbar',
                              );
                            } else {
                              AppSnackBar.showError(
                                context,
                                "signin.you_are_not_authorized_to_sign_in".tr(),
                              );
                            }

                            authProvider.emailcontrollersignin.clear();
                            authProvider.passwordcontrollersigin.clear();
                          } else {
                            AppSnackBar.showError(
                              context,
                              "signin.failed_to_sign_in".tr(),
                            );
                          }
                        }
                      },
                    ),
                    // //divider
                    // Row(
                    //   children: [
                    //     Expanded(child: Divider()),
                    //     Text(
                    //       "signin.or_continue_with".tr(),
                    //       style: AppTextStyle.labelDivider,
                    //     ),
                    //     Expanded(child: Divider()),
                    //   ],
                    // ),
                    // //google button
                    // GoogleButton(
                    //   onTap: () {
                    //     AppSnackBar.showError(
                    //       context,
                    //       "signin.this_feature_is_coming_soon".tr(),
                    //     );
                    //   },
                    //   text: "Google",
                    // ),
                    // //sign up text button
                    // SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "signin.dont_have_an_account".tr(),
                    //       style: AppTextStyle.subTextButton,
                    //     ),
                    //     textButton(
                    //       onTap: () {
                    //         Navigator.pushReplacementNamed(context, '/signup');
                    //       },
                    //       text: "signin.sign_up".tr(),
                    //     ),
                    //   ],
                    // ),
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
