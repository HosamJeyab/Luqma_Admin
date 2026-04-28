import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';

class TextFormEdit extends StatelessWidget {
  TextFormEdit({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.keyboardType,
  });
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: AppTextStyle.subTitle.copyWith(
          color: AppColor.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        hintText: hintText,
        hintStyle: AppTextStyle.subTitle.copyWith(
          color: AppColor.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
