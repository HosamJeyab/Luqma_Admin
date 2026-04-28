import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';
import 'package:luqma_admin/model/oder_model.dart';
import 'package:luqma_admin/provider/bottom_nav_bar_provider.dart';
import 'package:luqma_admin/service/firebase_service.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  final DatabaseService db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColor.primaryColor.withAlpha(50),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(icon, color: AppColor.primaryColor),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Text(title, style: AppTextStyle.appbar),
          Text(
            DateFormat(
              'EEEE,  MMM d',
              context.locale.toString(),
            ).format(DateTime.now()),
            style: AppTextStyle.subAppbar,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.read<BottomNavBarProvider>().changePage(1);
          },
          icon: Badge(
            label: StreamBuilder<List<OrderModel>>(
              stream: db.getOrders(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!
                        .where((e) => e.status == "pending")
                        .length
                        .toString(),
                  );
                }
                return Text("0");
              },
            ),
            child: Icon(
              Icons.notifications_active_outlined,
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
