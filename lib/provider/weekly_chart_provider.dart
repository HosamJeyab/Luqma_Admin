import 'package:flutter/material.dart';
import 'package:luqma_admin/model/oder_model.dart';

class WeeklyChartProvider extends ChangeNotifier {
  List<double> _weeklyData = List.filled(7, 0);
  List<double> get weeklyData => _weeklyData;

  void generateFromOrders(List<OrderModel> orders) {
    final now = DateTime.now();

    List<double> temp = List.filled(7, 0);

    for (var order in orders) {
      final date = DateTime.parse(order.createdAt.toString());

      if (date.isAfter(now.subtract(Duration(days: 7)))) {
        int index = date.weekday % 7;
        temp[index] += 1;
      }
    }
    _weeklyData = temp;
    notifyListeners();
  }

  int _selectedDayIndex = DateTime.now().weekday % 7;
  int get selectedDayIndex => _selectedDayIndex;
}
