import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';

class SettingsItemTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const SettingsItemTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColor.primaryColor),
      title: Text(title, style: AppTextStyle.appbar),
      trailing: Icon(Icons.arrow_forward_ios, color: AppColor.primaryColor),
    );
  }
}
