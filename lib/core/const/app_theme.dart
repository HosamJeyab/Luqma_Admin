import 'package:flutter/material.dart';
import '../const/app_color.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.background,
    primaryColor: AppColor.primaryColor,

    colorScheme: ColorScheme.light(
      primary: AppColor.primaryColor,
      secondary: AppColor.orange,
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColor.primaryTextColor),
      bodyMedium: TextStyle(color: AppColor.secondaryTextColor),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: AppColor.formLabelTextColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.formBorderColor),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0XFF121212),

    colorScheme: ColorScheme.dark(
      primary: AppColor.primaryColor,
      secondary: AppColor.orange,
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.grey),
    ),
  );
}
