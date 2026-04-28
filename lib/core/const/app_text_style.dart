import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';

class AppTextStyle {
  static const title = TextStyle(
    color: AppColor.primaryTextColor,
    fontSize: 32,
    fontFamily: 'Work Sans',

    fontWeight: FontWeight.bold,
  );

  static const subTitle = TextStyle(
    color: AppColor.secondaryTextColor,
    fontFamily: 'Work Sans',
    fontSize: 16,
  );

  static const textButton = TextStyle(
    color: AppColor.primaryColor,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: 'Work Sans',
  );
  static const subTextButton = TextStyle(
    color: AppColor.secondaryTextColor,
    fontSize: 14,
    fontFamily: 'Work Sans',
  );

  static const labelDivider = TextStyle(
    color: AppColor.formLabelTextColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const appbar = TextStyle(
    color: AppColor.primaryTextColor,
    fontSize: 20,
    fontFamily: 'Work Sans',
    fontWeight: FontWeight.bold,
  );
  static const subAppbar = TextStyle(
    color: AppColor.formLabelTextColor,
    fontSize: 12,
    fontFamily: 'Work Sans',
  );
}
