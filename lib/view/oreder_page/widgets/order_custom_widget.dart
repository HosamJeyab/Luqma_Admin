import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';
import 'package:luqma_admin/model/oder_model.dart';
import 'package:luqma_admin/service/firebase_service.dart';

class OrderCustomWidget extends StatelessWidget {
  OrderCustomWidget({
    super.key,
    required this.order,
    required this.index,
    required this.status,
    required this.widget,
  });
  final DatabaseService db = DatabaseService();
  final OrderModel order;
  final int index;
  final String status;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FutureBuilder<String>(
                  future: db.getImageUrl(order.items.first.productId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image.network(
                        order.items.first.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      );
                    }
                    return Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[200],
                      child: const Icon(Icons.fastfood),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              //order count and name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "order.order_number".tr() + " #${order.orderNumber}",
                      style: AppTextStyle.appbar.copyWith(fontSize: 18),
                    ),
                    Text(
                      "${order.userName} • ${order.createdAt.toString().substring(10, 16)}",
                      style: AppTextStyle.subTitle.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              //status
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColor.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(height: 1),
          ),

          //order items
          Text(
            order.items.map((e) => "${e.quantity}x ${e.name}").join(", "),
            style: AppTextStyle.subTitle.copyWith(color: Colors.blueGrey),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(height: 1),
          ),

          //price and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${order.total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                ),
              ),
              //widget
              widget,
            ],
          ),
        ],
      ),
    );
  }
}
