import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';

class CardDashboard extends StatelessWidget {
  CardDashboard({
    super.key,
    required this.color,
    required this.count,
    required this.icon,
    required this.text,
  });

  String count;
  String text;
  IconData icon;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 173,
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
  }
}
