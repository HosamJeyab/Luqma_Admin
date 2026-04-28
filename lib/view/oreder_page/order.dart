import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_const.dart';
import 'package:luqma_admin/core/widgets/appbar.dart';
import 'package:luqma_admin/model/oder_model.dart';
import 'package:luqma_admin/service/firebase_service.dart';
import 'package:luqma_admin/view/oreder_page/widgets/order_list.dart';

class Orders extends StatelessWidget {
  Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(
          title: "order.order".tr(),
          icon: Icons.shopping_bag_outlined,
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<List<OrderModel>>(
          stream: DatabaseService().getOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("order.error".tr()));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("order.no_orders".tr()));
            }

            final orders = snapshot.data!;

            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              padding: EdgeInsets.all(AppConst.padding),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return OrderList(order: orders[index], index: index);
              },
            );
          },
        ),
      ),
    );
  }
}
