import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';

class textButton extends StatelessWidget {
  textButton({super.key, required this.text, required this.onTap});
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: AppColor.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Work Sans',
          ),
        ),
      ),
    );
  }
}
