import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.95),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
//error snackbar
  static void showError(BuildContext context, String message) {
    show(
      context: context,
      message: message,
      icon: Icons.error_outline_rounded,
      color: Colors.redAccent,
    );
  }
//success snackbar
  static void showSuccess(BuildContext context, String message) {
    show(
      context: context,
      message: message,
      icon: Icons.check_circle_outline_rounded,
      color: Colors.green.shade600,
    );
  }
//no internet snackbar
  static void showNoInternet(BuildContext context) {
    show(
      context: context,
      message: "no_internet.no_internet_connection".tr(),
      icon: Icons.wifi_off_rounded,
      color: Colors.blueGrey.shade800,
    );
  }
  //warning snackbar
static void showWarning(BuildContext context, String message) {
  show(
    context: context,
    message: message,
    icon: Icons.exit_to_app_rounded,
    color: Colors.orange.shade700, 
  );
}
}