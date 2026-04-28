import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/utils/snackbar_helper.dart';

Future<bool> checkInternet(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult.contains(ConnectivityResult.none)) {
    if (context.mounted) {
      AppSnackBar.showNoInternet(context);
    }
    return false;
  }
  return true;
}
