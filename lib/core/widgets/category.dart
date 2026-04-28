import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';

class Category extends StatelessWidget {
  Category({super.key, required this.controller});
  final TextEditingController controller;
  final List<String> categories = [
    "category.Food".tr(),
    "category.Drinks".tr(),
    "category.Dessert".tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        focusColor: AppColor.primaryColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

        hintText: "category.category".tr(),
        hintStyle: AppTextStyle.subAppbar,
      ),
      items:
          categories.map((category) {
            return DropdownMenuItem(value: category, child: Text(category));
          }).toList(),
      onChanged: (value) {
        controller.text = value.toString();
      },
    );
  }
}
