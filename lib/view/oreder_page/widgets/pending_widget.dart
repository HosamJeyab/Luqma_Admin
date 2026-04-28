import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/model/oder_model.dart';
import 'package:luqma_admin/service/firebase_service.dart';
import 'package:luqma_admin/view/oreder_page/widgets/order_custom_widget.dart';
import 'package:luqma_admin/view/oreder_page/widgets/reject_dialog.dart';

class PendingWidget extends StatelessWidget {
  PendingWidget({super.key, required this.order, required this.index});
  final DatabaseService db = DatabaseService();
  final OrderModel order;
  final int index;
  @override
  Widget build(BuildContext context) {
    return OrderCustomWidget(
      order: order,
      index: index,
      status: order.status.toUpperCase(),
      widget: Row(
        children: [
          //accept button
          GestureDetector(
            onTap: () {
              db.updateOrderStatus(order.orderId, "preparing", null);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: AppColor.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "order.accept".tr(),
                style: TextStyle(
                  color: AppColor.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          //reject button
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => RejectDialog(order: order),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: AppColor.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "order.cancel".tr(),
                style: TextStyle(
                  color: AppColor.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
