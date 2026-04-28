import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_image.dart';

class GoogleButton extends StatelessWidget {
  GoogleButton({super.key, required this.onTap, required this.text});
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.white,
        fixedSize: Size(double.infinity, 54),
      ),
      onPressed: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImage.Google, height: 20, width: 20),
          Text(
            text,
            style: TextStyle(
              color: AppColor.primaryTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
