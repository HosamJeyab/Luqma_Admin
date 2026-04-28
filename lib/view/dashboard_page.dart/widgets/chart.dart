import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/provider/weekly_chart_provider.dart';
import 'package:provider/provider.dart';

class WeeklyPerformanceChart extends StatelessWidget {
  const WeeklyPerformanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    final chartProvider = context.watch<WeeklyChartProvider>();
    final weeklyData = chartProvider.weeklyData;
    final selectedDayIndex = chartProvider.selectedDayIndex;

    final List<String> days = [
      'dashboard.sat'.tr(),
      'dashboard.sun'.tr(),
      'dashboard.mon'.tr(),
      'dashboard.tue'.tr(),
      'dashboard.wed'.tr(),
      'dashboard.thu'.tr(),
      'dashboard.fri'.tr(),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: BarChart(
            BarChartData(
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          days[value.toInt() % 7],
                          style: TextStyle(
                            color:
                                value.toInt() == selectedDayIndex
                                    ? AppColor.primaryColor
                                    : Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              barGroups:
                  weeklyData.asMap().entries.map((entry) {
                    int index = entry.key;
                    double value = entry.value;
                    Color barColor =
                        (index == selectedDayIndex)
                            ? AppColor.primaryColor
                            : AppColor.primaryColor.withOpacity(0.3);

                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: value,
                          color: barColor,
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: 15,
                            color: Colors.grey[100]!,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
