import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_const.dart';

class formField extends StatelessWidget {
  formField({
    super.key,
    required this.text,
    required this.hintText,
    required this.controller,
    required this.password,
    required this.validator,
    required this.keyboardType,
  });
  final String text;
  final String hintText;
  final TextEditingController controller;
  final bool password;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        spacing: AppConst.spacing,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: AppColor.loginTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            obscureText: password,
            keyboardType: keyboardType,
            cursorColor: AppColor.formLabelTextColor,
            style: TextStyle(
              fontFamily: 'Work Sans',
              color: AppColor.loginTextColor,
              fontSize: 16,
            ),

            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontFamily: 'Work Sans',
                color: AppColor.formLabelTextColor,
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.formBorderColor),
                borderRadius: BorderRadius.circular(24),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.formBorderColor),
                borderRadius: BorderRadius.circular(24),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.formBorderColor),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            controller: controller,
          ),
        ],
      ),
    );
  }
}
