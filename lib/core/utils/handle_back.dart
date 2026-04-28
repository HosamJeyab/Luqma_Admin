import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/utils/snackbar_helper.dart';

class HandleBack {
  static DateTime? _lastBackPressed;
  //handle back press
  static Future<bool> handelBack(BuildContext context) async {
    DateTime now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > Duration(seconds: 2)) {
      _lastBackPressed = now;
      AppSnackBar.showWarning(
        context,
        "handle_back.press_back_again_to_exit".tr(),
      );
      return false;
    }
    return true;
  }
}
