import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luqma_admin/model/order_item_model.dart';

class OrderModel {
  final String userId;
  final String userName;
  final String userPhone;
  final String userAddress;
  final bool isPaid;
  final DateTime createdAt;
  final String orderId;
  final String status;
  final double total;
  final int orderNumber;
  final List<OrderItemModel> items;

  OrderModel({
    required this.userId,
    required this.userName,
    required this.createdAt,
    required this.userPhone,
    required this.userAddress,
    required this.isPaid,
    required this.orderId,
    required this.status,
    required this.total,
    required this.items,
    required this.orderNumber,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userPhone: json['userPhone'] ?? '',
      userAddress: json['userAddress'] ?? '',
      isPaid: json['isPaid'] ?? false,
      orderId: json['orderId'] ?? '',
      status: json['status'] ?? '',
      total: (json['total'] as num).toDouble(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      items:
          (json['items'] as List)
              .map((e) => OrderItemModel.fromJson(e))
              .toList(),
      orderNumber: json['orderCounter'] ?? 0,
    );
  }
}
