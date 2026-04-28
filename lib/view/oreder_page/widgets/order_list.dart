import 'package:flutter/material.dart';
import 'package:luqma_admin/model/oder_model.dart';
import 'package:luqma_admin/service/firebase_service.dart';
import 'package:luqma_admin/view/oreder_page/widgets/completed_widget.dart';
import 'package:luqma_admin/view/oreder_page/widgets/pending_widget.dart';
import 'package:luqma_admin/view/oreder_page/widgets/preparing_widget.dart';
import 'package:luqma_admin/view/oreder_page/widgets/ready_widget.dart';

class OrderList extends StatelessWidget {
  OrderList({super.key, required this.order, required this.index});
  final DatabaseService db = DatabaseService();
  final OrderModel order;
  final int index;

  @override
  Widget build(BuildContext context) {
    return order.status == "pending"
        ? PendingWidget(order: order, index: index)
        : order.status == "preparing"
        ? PreparingWidget(order: order, index: index)
        : order.status == "ready"
        ? ReadyWidget(order: order, index: index)
        : CompletedWidget(order: order, index: index);
  }
}
