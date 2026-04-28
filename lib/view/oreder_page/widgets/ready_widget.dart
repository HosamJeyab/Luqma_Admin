import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/model/oder_model.dart';
import 'package:luqma_admin/service/firebase_service.dart';
import 'package:luqma_admin/view/oreder_page/widgets/order_custom_widget.dart';

class ReadyWidget extends StatelessWidget {
  ReadyWidget({super.key, required this.order, required this.index});
  final DatabaseService db = DatabaseService();
  final OrderModel order;
  final int index;
  @override
  Widget build(BuildContext context) {
    return OrderCustomWidget(
      order: order,
      index: index,
      status: order.status.toUpperCase(),
      widget: //completed button
          GestureDetector(
        onTap: () {
          db.updateOrderStatus(order.orderId, "completed", null);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: AppColor.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Completed",
            style: TextStyle(
              color: AppColor.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
