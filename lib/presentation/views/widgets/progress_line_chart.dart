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
List<String> dayList = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

class LineChartProgress extends StatefulWidget {
  final double maxValuesY;
  final List<List<double>> values; // Format: [[x values], [y values]]
  final Color lineChartColor;
  final bool typeOfUse; // false: weekly progress (percentage), true: monthly progress (raw values)

  const LineChartProgress( {
    super.key,
    required this.typeOfUse,
    required this.lineChartColor,
    required this.maxValuesY,
    required this.values,
  });

  @override
  _LineChartProgressState createState() => _LineChartProgressState();
}

class _LineChartProgressState extends State<LineChartProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.forward();
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
              return LineChart(
                LineChartData(
                  maxY: widget.typeOfUse ? widget.maxValuesY : 100,
                  minY: 0,
                  gridData: const FlGridData(show: false),
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
                          final index = widget.values[0].indexWhere((x) => x == value);
                          if (index != -1) {
                            return Text(
                              widget.typeOfUse
                                  ? monthList[index % monthList.length]
                                  : dayList[index % dayList.length],
                              style: const TextStyle(fontSize: 10),
                            );
                          } else {
                            return const Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: widget.typeOfUse ? 20 : 30,
                        getTitlesWidget: (value, meta) {
                          if (!widget.typeOfUse) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: Text(
                                '${value.toInt()}%',
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: Text(
                                value.toStringAsFixed(0),
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: widget.lineChartColor,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            widget.lineChartColor.withOpacity(0.3),
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      spots: [
                        for (int i = 0; i < widget.values[0].length; i++)
                          FlSpot(
                            widget.values[0][i],
                            normalizedYValues[i] * _controller.value,
                          ),
                      ],
                    ),
                  ],
                  lineTouchData: LineTouchData(enabled: false),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
