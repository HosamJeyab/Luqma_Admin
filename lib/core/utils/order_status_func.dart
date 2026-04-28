import 'package:luqma_admin/model/oder_model.dart';

Map<String, int> getOrderStats(List<OrderModel> orders) {
  int pending = 0;
  int preparing = 0;
  int ready = 0;
  int completed = 0;

  for (var order in orders) {
    if (order.status == 'pending') pending++;
    if (order.status == 'preparing') preparing++;
    if (order.status == 'ready') ready++;
    if (order.status == 'completed') completed++;
  }

  return {
    'pending': pending,
    'preparing': preparing,
    'ready': ready,
    'completed': completed,
    'total': orders.length,
  };
}
