import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_const.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';
import 'package:luqma_admin/core/utils/order_status_func.dart';
import 'package:luqma_admin/core/widgets/appbar.dart';
import 'package:luqma_admin/model/oder_model.dart';
import 'package:luqma_admin/provider/weekly_chart_provider.dart';
import 'package:luqma_admin/service/firebase_service.dart';
import 'package:luqma_admin/view/dashboard_page.dart/widgets/card.dart';
import 'package:luqma_admin/view/dashboard_page.dart/widgets/chart.dart';
import 'package:luqma_admin/view/dashboard_page.dart/widgets/completed_card.dart';
import 'package:luqma_admin/view/dashboard_page.dart/widgets/completed_container.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(
          title: "dashboard.dashboard".tr(),
          icon: Icons.dashboard_outlined,
        ),
      ),
      body: StreamBuilder<List<OrderModel>>(
        stream: db.getOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!;
          final stats = getOrderStats(orders);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.read<WeeklyChartProvider>().generateFromOrders(orders);
            }
          });
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppConst.padding),
              child: Column(
                spacing: AppConst.spacing,
                children: [
                  //todays summary
                  Text(
                    "dashboard.today_summary".tr(),
                    style: AppTextStyle.appbar,
                  ),
                  Text(
                    "dashboard.real_time_order_performance".tr(),
                    style: AppTextStyle.subAppbar,
                  ),

                  //total orders and pending
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //total orders
                      CardDashboard(
                        color: AppColor.primaryColor,
                        count: stats['total'].toString(),
                        icon: Icons.list_alt_outlined,
                        text: "dashboard.total_orders".tr(),
                      ),
                      //pending
                      CardDashboard(
                        color: AppColor.orange,
                        count: stats['pending'].toString(),
                        icon: Icons.pending_actions_outlined,
                        text: "dashboard.pending".tr(),
                      ),
                    ],
                  ),

                  //preparing and ready
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //preparing
                      CardDashboard(
                        color: AppColor.blue,
                        count: stats['preparing'].toString(),
                        icon: Icons.soup_kitchen_outlined,
                        text: "dashboard.preparing".tr(),
                      ),
                      //ready
                      CardDashboard(
                        color: AppColor.green,
                        count: stats['ready'].toString(),
                        icon: Icons.delivery_dining_outlined,
                        text: "dashboard.ready".tr(),
                      ),
                    ],
                  ), //
                  CompletedCard(
                    text: "dashboard.completed".tr(),
                    icon: Icons.done_all_outlined,
                    color: AppColor.green,
                    count: stats['completed'].toString(),
                  ),
                  //orders not accepted yet
                  OrdersNotAcceptedYet(
                    text:
                        stats['pending'] == 0
                            ? "dashboard.all_orders_are_completed".tr()
                            : "dashboard.you_have_out_of_orders_not_accepted_yet"
                                .tr(
                                  args: [
                                    stats['pending'].toString(),
                                    stats['total'].toString(),
                                  ],
                                ),
                  ),
                  //weekly performance
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "dashboard.weekly_performance".tr(),
                      style: AppTextStyle.appbar,
                    ),
                  ),
                  //weekly performance chart
                  WeeklyPerformanceChart(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
