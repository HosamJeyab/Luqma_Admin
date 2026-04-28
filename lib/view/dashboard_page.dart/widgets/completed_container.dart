import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_const.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';
import 'package:luqma_admin/core/widgets/button.dart';
import 'package:luqma_admin/provider/auth_provider.dart';
import 'package:luqma_admin/provider/bottom_nav_bar_provider.dart';
import 'package:provider/provider.dart';

class OrdersNotAcceptedYet extends StatelessWidget {
  const OrdersNotAcceptedYet({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //completed orders
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "dashboard.orders_not_accepted_yet".tr(),
            style: AppTextStyle.appbar,
          ),
        ),
        //completed orders container
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(12),
          ),

          child: Column(
            spacing: AppConst.spacing,
            children: [
              Text(text, style: AppTextStyle.subTitle),

              // ont tap to move to order
              Button<AuthProvider>(
                text: "dashboard.view_orders".tr(),
                onTap: () {
                  context.read<BottomNavBarProvider>().changePage(1);
                },
                loadingSelector: (provider) => provider.isLoading,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
