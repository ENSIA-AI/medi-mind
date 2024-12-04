import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// List used for the conversion of data
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

class BarChartProgress extends StatefulWidget {
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
  _BarChartProgressState createState() => _BarChartProgressState();
}

class _BarChartProgressState extends State<BarChartProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.values.isEmpty || widget.values[0].length != widget.values[1].length) {
      return const Center(child: Text('Invalid data for chart'));
    }

    // Normalize Y values if typeOfUse is false (percentage mode)
    final normalizedYValues = widget.typeOfUse
        ? widget.values[1]
        : widget.values[1].map((y) => (y / widget.maxValuesY) * 100).toList();

    return SizedBox(
      width: 350,
      height: 243,
      child: Center(
        child: SizedBox(
          width: 320,
          height: 220,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return BarChart(
                BarChartData(
                  maxY: widget.typeOfUse ? widget.maxValuesY : 100,
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
                            widget.typeOfUse
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
                          if (!widget.typeOfUse) {
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
                    for (int i = 0; i < widget.values[0].length; i++)
                      BarChartGroupData(
                        x: widget.values[0][i].toInt(),
                        barRods: [
                          BarChartRodData(
                            toY: normalizedYValues[i] * _controller.value,
                            color: widget.barChartColor,
                            width: 14,
                            borderRadius: BorderRadius.zero,
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
