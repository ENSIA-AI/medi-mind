import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/widgets/app_barV2.dart';
import 'package:medi_mind/presentation/views/widgets/progress_bar_chart.dart';
import 'package:medi_mind/presentation/views/widgets/progress_circle.dart';
import 'package:medi_mind/presentation/views/widgets/progress_line_chart.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarV2(
        pageTitle: "My report",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // The title of the line chart
              Text(
                "Progress over the week:",
                style: BLUE_SUBHEADING_TEXT_STYLE,
              ),
              const SizedBox(height: 16),
              // The progress of the week
              const LineChartProgress(
                typeOfUse: false,
                lineChartColor: SECONDARY_BURGUNDY,
                maxValuesY: 100,
                values: [
                  [0, 1, 2, 3, 4, 5, 6],
                  [10, 20, 50, 80, 70, 40, 30],
                ],
              ),
              const SizedBox(height: 30),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WidgetMedProgress(
                      type: "Today Progress",
                      dateFormat: "11-11-2024",
                      progressVal: 0.75),
                      const SizedBox(width: 5),
                  WidgetMedProgress(
                      type: "Month Progress",
                      dateFormat: "November 2024",
                      progressVal: 0.5),
                ],
              ),
              const SizedBox(height: 40),

              Text(
                "Missing dosage over the year:",
                style: BLUE_SUBHEADING_TEXT_STYLE,
              ),
              const SizedBox(height: 16),

              const BarChartProgress(
                typeOfUse: true,
                barChartColor: PRIMARY_BLUE,
                maxValuesY: 8,
                values: [
                  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                  [2, 2, 3, 5, 4, 8, 2, 6, 0, 0, 0, 0, 0],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
