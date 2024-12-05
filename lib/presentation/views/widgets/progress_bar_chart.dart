import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


// list used for the conversion of data 
List<String> monthList = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];


// add the format check later  and values range check later 
class BarChartProgress extends StatelessWidget {
  final double maxValuesY;
  final List<List<double>> values; // Format: [[x values], [y values]]
  final Color barChartColor;
  final bool typeOfUse; // false: weekly progress (percentage), true: monthly progress (raw values)

  const BarChartProgress({
    super.key,
    required this.typeOfUse,
    required this.barChartColor,
    required this.maxValuesY,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure `values` has valid data
    if (values.isEmpty || values[0].length != values[1].length) {
      return const Center(child: Text('Invalid data for chart'));
    }

    // Normalize Y values if typeOfUse is false (percentage mode)
    final normalizedYValues = typeOfUse
        ? values[1]
        : values[1].map((y) => (y / maxValuesY) * 100).toList();

    return Container(
      width: 350,
      height: 243,
      child: Center(
        child: SizedBox(
          width: 320,
          height: 220,
          child: BarChart(
            BarChartData(
              maxY: typeOfUse ? maxValuesY : 100,
              gridData: const FlGridData(
                show: false,
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      return Text(
                        typeOfUse
                            ? monthList[index % monthList.length]
                            : index.toString(),
                        style: const TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40, 
                    getTitlesWidget: (value, meta) {
                      if (!typeOfUse) {
                        return Text(
                          '${value.toInt()}%',
                          style: const TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return Text(
                          value.toStringAsFixed(0),
                          style: const TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                        );
                      }
                    },
                  ),
                ),
              ),
              barGroups: [
                for (int i = 0; i < values[0].length; i++)
                  BarChartGroupData(
                    x: values[0][i].toInt(),
                    barRods: [
                      BarChartRodData(
                        toY: normalizedYValues[i],
                        color: barChartColor,
                        width: 14,
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
