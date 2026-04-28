import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';

class ItemInfo extends StatelessWidget {
  const ItemInfo({
    super.key,
    required this.itemName,
    required this.decoration,
    this.maxLines,
    required this.controller,
  });
  final String itemName;
  final String decoration;
  final int? maxLines;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //item name
        Align(
          alignment: Alignment.centerLeft,
          child: Text(itemName, style: AppTextStyle.appbar),
        ),
        //item name text field
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: decoration,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}
