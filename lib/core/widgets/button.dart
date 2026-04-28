import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:provider/provider.dart';

class Button<T extends ChangeNotifier> extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.onTap,
    required this.loadingSelector,
  });
  final String text;
  final void Function()? onTap;
  final bool Function(T) loadingSelector;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<T>();
    final isLoading = loadingSelector(provider);
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Material(
        color: AppColor.primaryColor,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          child: Container(
            width: 342,
            height: 56,
            alignment: Alignment.center,
            child: Text(
              isLoading ? "button.loading".tr() : text,
              style: TextStyle(
                color: AppColor.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
