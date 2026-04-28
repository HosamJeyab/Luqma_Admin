import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';

class CompletedCard extends StatelessWidget {
  const CompletedCard({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    required this.count,
  });
  final String text;
  final IconData icon;
  final Color color;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 118,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //icon
          Icon(icon, color: color),
          //count
          Text(count, style: AppTextStyle.appbar),
          //text
          Text(text, style: AppTextStyle.subTitle),
        ],
      ),
    );
    ;
  }
}
